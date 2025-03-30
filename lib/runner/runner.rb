require 'timeout'
require_relative '../logger'
require_relative '../human_eval/assert'
require_relative '../solver'
require_relative '../report/generator'
require_relative '../model/to_path'
require_relative '../models'
require_relative 'report'

module Runner
  # Класс Runner отвечает за запуск и обработку тестов для решений задач
  # Позволяет запускать тесты для конкретной задачи или модели, собирать результаты
  # и генерировать отчеты о производительности различных моделей
  class Runner
    include Logger
    include Report

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

      if model && !model.to_s.match?(/^[a-zA-Z0-9_-]+$/) && !model.to_s.match?(%r{^[a-zA-Z0-9/_:-]+$})
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
      models_manager = Models.new

      tasks_to_run.each do |current_task|
        test_file = "tasks/#{current_task}-assert.rb"
        unless File.exist?(test_file)
          error "Файл с тестами #{test_file} не найден"
          next
        end

        # Определяем список решений для тестирования
        solutions = if model
                      if model.include?('/') || model.include?(':') || model.include?('-')
                        # Если передано оригинальное имя модели, ищем ключ модели
                        # и затем используем Model::ToPath для преобразования в путь
                        path_name = Model::ToPath.to_path(model)
                        solution = Dir.glob("tasks/#{current_task}-#{path_name}.rb").first
                      else
                        # Используем переданное имя как есть (предполагается, что это ключ модели)
                        path_name = model
                        solution = Dir.glob("tasks/#{current_task}-#{path_name}.rb").first
                      end
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
          model_path_name = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
          # Получаем оригинальное имя модели для отображения
          original_model_name = Model::ToPath.from_file_path(solution, models_manager) || model_path_name
          normal_log "Testing solution #{solution} for model #{original_model_name}"
          success = test_solution(current_task, solution)
          debug_log "Test result for #{original_model_name}: #{success}"
          @results[current_task][original_model_name] = success
        rescue => e
          debug_log "Ошибка при тестировании #{solution}: #{e.message}"
          original_model_name = Model::ToPath.from_file_path(solution, models_manager) || model_path_name
          @results[current_task][original_model_name] = false
        end
      end

      # Если не было найдено ни одного решения, возвращаем пустой хэш
      return {} unless has_solutions

      # Если установлен флаг генерации отчетов, генерируем их
      if @options[:report]
        report_data = {
          model_stats: get_model_stats,
          task_results: @results
        }
        Report::Generator.new(report_data).generate_all
      end
      
      # Всегда выводим итоговую статистику в консоль
      # Получаем список моделей
      models_list = models
      # Вывод итоговой статистики
      display_total_console(tasks_to_run, models_list)

      @results
    end

    def get_model_stats
      # Находим все файлы с решениями в директории tasks
      solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }
      tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort
      models_manager = Models.new

      # Используем оригинальные имена моделей для статистики
      models = solutions.map do |f|
        Model::ToPath.from_file_path(f, models_manager) || 
          (File.basename(f).split('-')[1..].join('-').sub('.rb', ''))
      end.compact.uniq.sort

      return [] if models.empty? || tasks.empty? || @results.empty?

      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        # Находим все задачи, для которых у нас есть результаты данной модели
        total_tasks = tasks.count { |task| @results[task]&.key?(model) }
        next nil if total_tasks.zero? # Пропускаем модели без результатов
        
        # Подсчитываем количество успешно пройденных тестов
        passed_tasks = tasks.count { |task| @results[task][model] == true }
        percentage = total_tasks > 0 ? (passed_tasks * 100.0 / total_tasks).round : 0
        
        # Возвращаем более детальную статистику
        [model, passed_tasks, total_tasks, percentage]
      end.compact

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, _, _, percentage| -percentage }

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
      models_manager = Models.new
      find_solution_files.map do |f|
        # Всегда пытаемся получить оригинальное имя модели
        Model::ToPath.from_file_path(f, models_manager) || 
          (File.basename(f).split('-')[1..].join('-').sub('.rb', ''))
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
        include Logger

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
            include Logger

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

    def display_results(tasks, models)
      # Если установлен флаг генерации отчетов, генерируем их
      if @options[:report]
        report_data = {
          model_stats: get_model_stats,
          task_results: @results
        }
        Report::Generator.new(report_data).generate_all
      end

      # Короткий отчет по результатам прогона - всегда отображаем
      display_total_console(tasks, models)
    end

    def find_solution_files(task = nil)
      pattern = task ? "tasks/#{task}-*.rb" : 'tasks/t*-*.rb'
      Dir.glob(pattern).reject { |f| f.end_with?('-assert.rb') }
    end
  end
end 