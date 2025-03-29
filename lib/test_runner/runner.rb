require 'timeout'
require_relative '../human_eval/logger'
require_relative '../human_eval/assert'
require_relative '../human_eval/log_levels'
require_relative '../human_eval/solver'
require_relative '../human_eval/report_generator'
require_relative '../human_eval/reports/generator'

module TestRunner
  # Класс Runner отвечает за запуск и обработку тестов для решений задач
  # Позволяет запускать тесты для конкретной задачи или модели, собирать результаты
  # и генерировать отчеты о производительности различных моделей
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    DONE_MARK = "\e[32m✓\e[0m".freeze # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m".freeze # Красный цвет

    def initialize(options = {})
      @options = options
      @results = {}
      self.log_level = @options[:log_level] || :normal
      @timeout = @options[:timeout] || 5 # Таймаут по умолчанию 5 секунд
    end

    def run_tests(task: nil, model: nil)
      # Валидация параметров
      if task && !task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end

      if model && !model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error 'Ошибка: Неверный формат названия модели'
        return {}
      end

      # Определяем список задач для тестирования
      tasks_to_run = if task
                       [task]
                     else
                       find_solution_files.map { |f| File.basename(f).gsub(/-.*$/, '') }.uniq.sort
                     end

      if tasks_to_run.empty?
        error 'Ошибка: Не найдены файлы с решениями'
        return {}
      end

      @results = Hash.new { |h, k| h[k] = {} }
      has_solutions = false

      tasks_to_run.each do |current_task|
        test_file = "tasks/#{current_task}-assert.rb"
        unless File.exist?(test_file)
          error "Файл с тестами #{test_file} не найден"
          next
        end

        # Определяем список решений для тестирования
        solutions = if model
                      solution = Dir.glob("tasks/#{current_task}-#{model}.rb").first
                      solution ? [solution] : []
                    else
                      find_solution_files(current_task)
                    end

        if solutions.empty?
          error "Решения для задачи #{current_task} не найдены"
          next
        end

        has_solutions = true

        solutions.each do |solution|
          current_model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
          normal_log "Testing solution #{solution} for model #{current_model}"
          success = test_solution(current_task, solution)
          debug_log "Test result for #{current_model}: #{success}"
          @results[current_task][current_model] = success
        rescue => e
          debug_log "Ошибка при тестировании #{solution}: #{e.message}"
          @results[current_task][current_model] = false
        end
      end

      # Если не было найдено ни одного решения, возвращаем пустой хэш
      return {} unless has_solutions

      if @options[:report]
        report_data = {
          model_stats: get_model_stats,
          task_results: @results
        }
        HumanEval::ReportGenerator.new(report_data).generate_all
        display_total_console(tasks_to_run, models)
      end

      @results
    end

    def get_model_stats
      # Находим все файлы с решениями в директории tasks
      solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }
      tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort

      models = solutions.map do |f|
        filename = File.basename(f)
        next if filename.end_with?('_asserts.rb')

        filename.split('-')[1..].join('-').sub('.rb', '')
      end.compact.uniq.sort

      return [] if models.empty? || tasks.empty? || @results.empty?

      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        total_tasks = tasks.count { |task| @results[task]&.key?(model) }
        next [model, 0] if total_tasks.zero?

        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end.compact

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, percentage| -percentage }

      # Возвращаем результат
      model_stats
    end

    def log_error_details(error)
      debug_log '  ❌ Тест не пройден:'
      error_class = error[:class] || 'Unknown error'
      debug_log "     #{error_class}: #{error[:message]}"
      debug_log '     Стек вызовов:'
      if error[:backtrace]&.any?
        error[:backtrace].each { |line| debug_log "       #{line}" }
      else
        debug_log '       Стек вызовов недоступен'
      end
    end

    private

    def models
      find_solution_files.map do |f|
        filename = File.basename(f)
        next if filename.end_with?('_asserts.rb')

        filename.split('-')[1..].join('-').sub('.rb', '')
      end.compact.uniq.sort
    end

    def tasks
      find_solution_files
        .map { |f| File.basename(f) }
        .map { |f| f.gsub(/-.*$/, '') }
        .uniq
        .sort
    end

    def file_exists?(file)
      return true if File.exist?(file)

      error "\nРешение #{File.basename(file)}:"
      error "  ❌ Файл не найден: #{file}"
      false
    end

    def test_solution(task, solution_file)
      test_file = "tasks/#{task}-assert.rb"

      return false unless file_exists?(solution_file)
      return false unless file_exists?(test_file)

      begin
        test_content = File.read(test_file)
        test_lines = test_content.lines.map(&:strip).reject { |line| line.empty? || line.start_with?('#') }

        if test_lines.empty?
          debug_log '  ❌ Тест файл пуст или содержит только комментарии'
          return false
        end

        solution_content = File.read(solution_file)

        debug_log '  📝 Анализ синтаксиса решения...'
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        debug_log '  ✅ Синтаксис решения корректен'
      rescue SyntaxError => e
        debug_log '  ❌ Ошибка синтаксиса в решении:'
        debug_log "     #{e.message}"
        return false
      rescue => e
        debug_log '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при проверке синтаксиса:'
        debug_log "     #{e.class}: #{e.message}"
        debug_log '     Тесты могут не пройти из-за отсутствия необходимых методов'
      end

      test_context = Module.new do
        include HumanEval::Assert
        include HumanEval::LogLevels
        include HumanEval::Logger

        # Загружаем стандартные библиотеки Ruby с обработкой ошибок
        %w[prime set json date time base64 digest securerandom pathname].each do |lib|
          require lib
        rescue LoadError => e
          debug_log "  ⚠️ Библиотека #{lib} недоступна: #{e.message}"
        end

        class << self
          attr_accessor :log_level, :options
        end

        def self.handle_error(e)
          debug_log "Handling error: #{e.class} - #{e.message}"
          debug_log "Backtrace: #{e.backtrace&.join("\n")}"
          {
            status: :error,
            error: {
              class: e.class.name,
              message: e.message || 'Unknown error',
              backtrace: e.backtrace || []
            }
          }
        end

        begin
          module_eval(solution_content)
        rescue => e
          log_solution_load_error(e)
        end

        extend self
      end

      test_context.log_level = @options[:log_level] || :normal

      begin
        test_content = File.read(test_file)
        debug_log '  🧪 Запуск тестов...'
        debug_log '  📄 Содержимое теста:'
        debug_log test_content
        debug_log '  📄 Содержимое решения:'
        debug_log solution_content
        debug_log '  🔍 Доступные методы в контексте:'
        debug_log test_context.methods.sort.inspect

        result = Queue.new
        thread = Thread.new do
          # Создаем новый контекст для каждого теста
          test_context = Module.new do
            include HumanEval::Assert
            include HumanEval::LogLevels
            include HumanEval::Logger

            class << self
              attr_accessor :log_level, :options
            end

            def self.handle_error(e)
              debug_log "Handling error: #{e.class} - #{e.message}"
              debug_log "Backtrace: #{e.backtrace&.join("\n")}"
              {
                status: :error,
                error: {
                  class: e.class.name,
                  message: e.message || 'Unknown error',
                  backtrace: e.backtrace || []
                }
              }
            end
          end

          begin
            test_context.module_eval(solution_content)
          rescue => e
            log_solution_load_error(e)
          end

          test_context.extend(test_context)
          test_context.log_level = @options[:log_level] || :normal
          test_context.options = @options.dup # Добавляем .dup чтобы избежать проблем с разделяемыми объектами

          begin
            debug_log '  🔄 Выполняем тесты в контексте...'
            debug_log "  🔄 Выполняем тесты для #{File.basename(solution_file)}..."

            # Показываем и выполняем тесты по одному
            debug_log '  📝 Тесты:'
            test_lines = test_content.split("\n")
            test_lines.each_with_index do |line, idx|
              next if line.strip.empty?

              line_number = idx + 1
              debug_log "     #{line_number}: #{line.strip}"

              begin
                test_context.module_eval(line)
              rescue HumanEval::Assert::AssertionError => e
                # Сохраняем информацию о не пройденном тесте
                File.basename(solution_file).split('-')[1..].join('-').sub('.rb', '')
                task = File.basename(solution_file).split('-').first

                debug_log "\n  ❌ Тест не пройден на строке #{line_number}:"
                debug_log "     #{line.strip}"

                if e.expected && e.actual
                  debug_log "     Ожидалось: #{e.expected.inspect}"
                  debug_log "     Получено: #{e.actual.inspect}"
                end

                result.push({
                              status: :error,
                              error: {
                                class: e.class.name,
                                message: e.message,
                                expected: e.expected,
                                actual: e.actual,
                                line: line_number,
                                test: line.strip
                              }
                            })
                return false
              end
            end

            debug_log '  ✅ Тесты выполнены успешно'
            result.push({ status: :success })
          rescue => e
            debug_log "  ❌ Ошибка при выполнении тестов: #{e.class} - #{e.message}"
            debug_log "  ❌ Ошибка: #{e.message || 'Unknown error'}"
            result.push(test_context.handle_error(e))
          rescue Exception => e
            debug_log "  ❌ Критическая ошибка при выполнении тестов: #{e.class} - #{e.message}"
            result.push({
                          status: :error,
                          error: {
                            class: e.class.name,
                            message: e.message || 'Unknown error',
                            backtrace: e.backtrace || []
                          }
                        })
          end
        end

        begin
          Timeout.timeout(@timeout) do
            debug_log '  ⏳ Ожидаем результат выполнения тестов...'
            res = result.pop
            debug_log "   Получен результат: #{res.inspect}"
            case res[:status]
            when :success
              debug_log '  ✅ Все тесты пройдены успешно'
              return true
            when :error
              error = res[:error]
              log_error_details(error)
              return false
            else
              error "  ❌ Неизвестный статус результата: #{res[:status]}"
              return false
            end
          end
        rescue Timeout::Error
          thread.kill
          thread.join(1) # Даем потоку секунду на завершение
          debug_log "  ❌ Превышен лимит времени выполнения (#{@timeout} секунд)"
          debug_log '     Возможно, в решении есть бесконечный цикл'
          false
        ensure
          thread.kill unless thread.nil? || !thread.alive?
        end
      rescue Interrupt => e
        error "\n  ⚠️  Тест прерван пользователем (Ctrl+C)"
        debug_log "  📍 Место прерывания: #{e.backtrace.first}"
        false
      rescue => e
        raise_log(e, 'Неожиданная ошибка')
        false
      rescue Exception => e
        raise_log(e, 'Критическая ошибка')
        false
      end
    end

    def raise_log(e, msg)
      debug_log " ❌ #{msg}:"
      debug_log "    Тип: #{e.class}"
      debug_log "    Сообщение: #{e.message}"
      debug_log "    Место ошибки: #{e.backtrace.first}"
      debug_log '    Полный стек вызовов:'
      e.backtrace.each { |line| debug_log "       #{line}" }
    end

    def handle_timeout(thread)
      thread&.kill
      thread&.join(1) # Даем потоку секунду на завершение
      error "  ❌ Превышен лимит времени выполнения (#{@timeout} секунд)"
      error '     Возможно, в решении есть бесконечный цикл'
      false
    end

    def display_total_console(tasks, models)
      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, percentage| -percentage }

      # Выводим общую статистику
      log "\nРезультаты тестирования моделей:"
      model_stats.each do |model, percentage|
        log "- #{model}: #{colorize("#{percentage}%", percentage)}"
      end
    end

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then "\e[31m" # Красный
              when 34..66 then "\e[33m" # Желтый
              else "\e[32m" # Зеленый
              end
      "#{color}#{text}\e[0m"
    end

    def display_results(tasks, models)
      # Создаем отчеты через генератор отчетов
      generator = HumanEval::Reports::Generator.new(
        output_dir: 'reports',
        format: 'all',
        results: @results,
        tasks: tasks,
        models: models
      )

      # Генерируем отчеты
      generator.generate

      # Отображаем результаты в консоли в зависимости от опции report_total
      display_total_console(tasks, models) if @options[:report]
    end

    def get_model_info(model_key)
      # Используем класс Models для получения информации о модели
      begin
        require_relative '../models'
        models_manager = Models.new
        model_info = models_manager.get(model_key)
        model_info || { 'name' => model_key, 'provider' => 'unknown' }
      rescue => e
        # В случае ошибки возвращаем базовую информацию
        { 'name' => model_key, 'provider' => 'unknown' }
      end
    end

    def get_display_model_name(model_key)
      model_info = get_model_info(model_key)
      name = model_info['name']
      provider = model_info['provider']
      note = model_info['note']

      display_name = name.dup
      display_name << " (#{provider})" if provider != 'unknown'
      display_name << " - #{note}" if note

      display_name
    end

    # Форматирует название модели с мягкими переносами
    # @param text [String] текст для форматирования
    # @return [String] отформатированный текст с мягкими переносами
    def add_soft_hyphens(text)
      text.gsub('_', '_&shy;')
    end

    def find_solution_files(task = nil)
      pattern = task ? "tasks/#{task}-*.rb" : 'tasks/t*-*.rb'
      Dir.glob(pattern).reject { |f| f.end_with?('-assert.rb') }
    end
  end
end
