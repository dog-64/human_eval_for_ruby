# frozen_string_literal: true

require 'terminal-table'
require 'timeout'
require_relative '../human_eval/logger'
require_relative '../human_eval/assert'
require_relative '../human_eval/log_levels'
require 'shellwords'
require 'fileutils'
require_relative '../human_eval/solver'
require_relative '../human_eval/reports/generator'
require_relative 'report'
require 'thor'

module TestRunner
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    DONE_MARK = "\e[32m✓\e[0m" # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m" # Красный цвет

    def initialize(options = {})
      @options = options
      @results = {}
      self.log_level = @options[:log_level] || :normal
      @timeout = @options[:timeout] || 5 # Таймаут по умолчанию 5 секунд
      @report = Report.new(@options)
    end

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then "\e[31m" # Красный
              when 34..66 then "\e[33m" # Желтый
              else "\e[32m" # Зеленый
              end
      "#{color}#{text}\e[0m"
    end

    def run_all_tests
      tasks = find_solution_files.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort
      if tasks.empty?
        error 'Ошибка: Не найдены файлы с решениями'
        return {}
      end

      models = find_solution_files.map do |f|
        filename = File.basename(f)
        next if filename.end_with?('_asserts.rb')

        filename.split('-')[1..].join('-').sub('.rb', '')
      end.compact.uniq.sort

      @results = Hash.new { |h, k| h[k] = {} }

      tasks.each do |task|
        task_solutions = find_solution_files(task)
        debug_log "Processing task #{task} with solutions: #{task_solutions.inspect}"

        task_solutions.each do |solution|
          model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
          debug_log "Testing solution #{solution} for model #{model}"
          success = test_solution(task, solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
        end
      end

      debug_log "Final results: #{@results.inspect}"
      
      # Генерируем отчеты
      report_data = {
        model_stats: get_model_stats,
        task_results: @results
      }
      
      HumanEval::Reports::Generator.new(
        output_dir: 'reports',
        format: 'all',
        results: @results,
        tasks: tasks,
        models: models
      ).generate
      
      display_total_console(tasks, models)
      @results
    end

    def run_task_tests(task)
      unless task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end
      test_file = "tasks/#{task}-assert.rb"
      unless File.exist?(test_file)
        error "Файл с тестами #{test_file} не найден"
        return {}
      end

      solutions = find_solution_files(task)
      if solutions.empty?
        error "Решения для задачи #{task} не найдены"
        return {}
      end

      models = solutions.map { |s| File.basename(s).split('-')[1..].join('-').sub('.rb', '') }
      @results = Hash.new { |h, k| h[k] = {} }

      solutions.each do |solution|
        model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
        success = test_solution(task, solution)
        @results[task][model] = success
      end

      display_results([task], models)
      @results
    end

    def run_model_tests(task, model)
      unless task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end

      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error 'Ошибка: Неверный формат названия модели'
        return {}
      end
      solution = Dir.glob("tasks/#{task}-#{model}.rb").first

      if solution.nil?
        error "Решение для задачи #{task} модели #{model} не найдено"
        return {}
      end

      unless File.exist?(solution)
        error "Решение для задачи #{task} модели #{model} не найдено"
        return {}
      end

      @results = Hash.new { |h, k| h[k] = {} }
      begin
        success = test_solution(task, solution)
        @results[task][model] = success || false
      rescue Interrupt => e
        error "Тест прерван для задачи #{task} модели #{model}"
        @results[task][model] = false
      end

      begin
        display_results([task], [model])
      rescue Interrupt
        error "Отображение результатов прервано для задачи #{task} модели #{model}"
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

      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, percentage| -percentage }

      # Возвращаем результат
      model_stats
    end

    def log_error_details(error)
      debug_log '  ❌ Тест не пройден:'
      debug_log "     #{error[:class]}: #{error[:message]}"
      debug_log '     Стек вызовов:'
      if error[:backtrace]&.any?
        error[:backtrace].each { |line| debug_log "       #{line}" }
      else
        debug_log '       Стек вызовов недоступен'
      end
    end

    # Этот метод больше не используется, так как функционал отчетов
    # был перенесен в отдельный модуль. Метод оставлен для обратной
    # совместимости и будет удален в следующих версиях.
    #
    # @deprecated Используйте Reports::Generator вместо этого метода
    def create_reports(tasks, models)
      warn "DEPRECATED: Метод create_reports устарел и будет удален. Используйте Reports::Generator."
      # Оставляем пустую реализацию
    end

    private

    def test_solution(task, solution_file)
      test_file = "tasks/#{task}-assert.rb"
      model = File.basename(solution_file).split('-')[1..].join('-').sub('.rb', '')

      unless File.exist?(solution_file)
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл решения не найден: #{solution_file}"
        @report.save_result(model: model, task: task, success: false)
        return false
      end

      unless File.exist?(test_file)
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл тестов не найден: #{test_file}"
        @report.save_result(model: model, task: task, success: false)
        return false
      end

      # Проверяем на пустой файл
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error '  ❌ Файл решения пуст'
        @report.save_result(model: model, task: task, success: false)
        return false
      end

      begin
        debug_log '  📝 Анализ синтаксиса решения...'
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        debug_log '  ✅ Синтаксис решения корректен'
      rescue SyntaxError => e
        error '  ❌ Ошибка синтаксиса в решении:'
        error "     #{e.message}"
        @report.save_result(model: model, task: task, success: false)
        return false
      rescue StandardError => e
        # Если в решении есть посторонний код, который вызывает ошибку,
        # логируем ошибку, но продолжаем выполнение
        warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при проверке синтаксиса:'
        warn "     #{e.class}: #{e.message}"
        warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
      end

      test_context = Module.new do
        include HumanEval::Assert
        include HumanEval::LogLevels

        # Загружаем стандартные библиотеки Ruby с обработкой ошибок
        %w[prime set json date time base64 digest securerandom pathname].each do |lib|
          begin
            require lib
          rescue LoadError => e
            warn "  ⚠️ Библиотека #{lib} недоступна: #{e.message}"
          end
        end

        class << self
          attr_writer :log_level
        end

        class << self
          attr_reader :log_level
        end

        class << self
          attr_writer :options
        end

        class << self
          attr_reader :options
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
        rescue StandardError => e
          # Если в решении есть посторонний код, который вызывает ошибку,
          # логируем ошибку, но продолжаем выполнение тестов
          warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при загрузке в контекст тестов:'
          warn "     #{e.class}: #{e.message}"
          warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
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

            class << self
              attr_writer :log_level
            end

            class << self
              attr_reader :log_level
            end

            class << self
              attr_writer :options
            end

            class << self
              attr_reader :options
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

          test_context.module_eval(solution_content)
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
                @report.save_result(model: model, task: task, success: false)
                return false
              end
            end

            debug_log '  ✅ Тесты выполнены успешно'
            result.push({ status: :success })
            @report.save_result(model: model, task: task, success: true)
            true
          rescue StandardError => e
            debug_log "  ❌ Ошибка при выполнении тестов: #{e.class} - #{e.message}"
            debug_log "  ❌ Ошибка: #{e.message || 'Unknown error'}"
            result.push(test_context.handle_error(e))
            @report.save_result(model: model, task: task, success: false)
            false
          rescue Exception => e
            debug_log "  ❌ Критическая ошибка при выполнении тестов: #{e.class} - #{e.message}"
            @report.save_result(model: model, task: task, success: false)
            false
          end
        end

        thread.join(@timeout)
        if thread.alive?
          thread.kill
          error "  ❌ Тест превысил лимит времени (#{@timeout} секунд)"
          @report.save_result(model: model, task: task, success: false)
          return false
        end

        result = result.pop
        case result[:status]
        when :success
          true
        when :error
          log_error_details(result[:error])
          false
        else
          error "  ❌ Неизвестный статус результата: #{result[:status]}"
          false
        end
      rescue StandardError => e
        error "  ❌ Ошибка при чтении тестов: #{e.message}"
        @report.save_result(model: model, task: task, success: false)
        false
      end
    end

    def handle_timeout(thread)
      thread.kill
      thread.join(1) # Даем потоку секунду на завершение
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

    def display_detailed_console(tasks, models)
      # Существующий код для детального отчета
      rows = []
      tasks.each do |task|
        row = [task]
        models.each do |model|
          status = @results[task][model]
          mark = status ? DONE_MARK : FAIL_MARK
          row << mark
        end
        rows << row
      end

      # Создаем заголовок таблицы
      header = ['Task'] + models.map { |m| m.gsub('_', "\n") }

      # Создаем и выводим таблицу
      table = Terminal::Table.new(
        headings: header,
        rows: rows,
        style: {
          border_x: '-',
          border_y: '|',
          border_i: '+',
          alignment: :center
        }
      )

      log "\nДетальные результаты:"
      log table
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
      if @options[:report_total]
        display_total_console(tasks, models)
      else
        display_detailed_console(tasks, models)
      end
    end

    def get_model_info(model_key)
      # Проверяем доступность константы MODELS
      if defined?(HumanEval::SolverClass::MODELS)
        HumanEval::SolverClass::MODELS[model_key] || { name: model_key, provider: 'unknown' }
      else
        { name: model_key, provider: 'unknown' }
      end
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

  class CLI < Thor
    package_name 'Test Runner'

    desc 'all', 'Запустить все тесты'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def all
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_all_tests
    end

    desc 'task TASK', 'Запустить тесты для конкретной задачи'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def task(task)
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_task_tests(task)
    end

    desc 'model TASK MODEL', 'Запустить тесты для конкретной модели'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def model(task, model)
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_model_tests(task, model)
    end

    def self.exit_on_failure?
      true
    end

    def self.start(given_args = ARGV, config = {})
      # Добавляем опцию --report-total по умолчанию только в production окружении
      unless ENV['RACK_ENV'] == 'test'
        given_args << "--report-total" unless given_args.any? { |arg| arg.include?("report-total") }
      end
      super
    end
  end
end
