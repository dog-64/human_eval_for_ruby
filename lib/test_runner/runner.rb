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
require_relative 'test_executor'
require_relative 'stats_calculator'
require 'thor'

# Класс для запуска и управления тестами решений
# @note Этот класс отвечает за выполнение тестов для различных решений задач
#       и генерацию отчетов о результатах тестирования
module TestRunner
  # Основной класс для запуска тестов и управления результатами
  # @attr_reader [Hash] options Опции конфигурации для запуска тестов
  # @attr_reader [Integer] timeout Максимальное время выполнения одного теста
  # @attr_reader [Boolean] generate_reports Флаг генерации отчетов
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels
    include TestExecutor
    include StatsCalculator

    DONE_MARK = "\e[32m✓\e[0m" # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m" # Красный цвет

    attr_reader :options, :results, :log_level, :timeout, :report

    def initialize(options = {})
      @options = options
      @results = {}
      @log_level = options[:log_level] || :normal
      @timeout = options[:timeout] || 5
      @report = HumanEval::Reports::Generator.new(
        output_dir: 'reports',
        format: 'all',
        report_total: @options[:report_total]
      )
    end

    def debug_log(message)
      return unless @log_level == :debug
      puts "runner.rb:#{caller_locations(1,1)[0].lineno} [DEBUG] | #{message}"
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

      models = extract_models(find_solution_files)
      @results = Hash.new { |h, k| h[k] = {} }

      tasks.each do |task|
        task_solutions = find_solution_files(task)
        debug_log "Processing task #{task} with solutions: #{task_solutions.inspect}"

        task_solutions.each do |solution|
          model = extract_model_from_file(solution)
          debug_log "Testing solution #{solution} for model #{model}"
          success = test_solution(task, solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
        end
      end

      debug_log "Final results: #{@results.inspect}"

      # Генерируем отчеты
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

      models = extract_models(solutions)
      @results = Hash.new { |h, k| h[k] = {} }

      solutions.each do |solution|
        model = extract_model_from_file(solution)
        success = test_solution(task, solution)
        @results[task][model] = success
      end

      display_results([task], models)
      @results
    end

    def run_model_tests(task, model)
      @results = Hash.new { |h, k| h[k] = {} }
      
      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error 'Ошибка: Неверный формат названия модели'
        return {}
      end

      if task.nil?
        run_all_model_tests(model)
      else
        run_single_model_test(task, model)
      end

      @results
    end

    # Возвращает статистику по моделям
    # @return [Array<Array>] Массив пар [модель, процент успешных тестов]
    def model_stats
      calculate_model_stats
    end

    def log_error_details(error)
      debug_log '  ❌ Тест не пройден:'
      debug_log "     #{error[:class]}: #{error[:message]}"
      if error[:backtrace]&.any?
        debug_log '     Стек вызовов:'
        error[:backtrace].each do |line|
          debug_log "       #{line}"
        end
      else
        debug_log '     Стек вызовов:'
        debug_log '       Стек вызовов недоступен'
      end
    end

    # Этот метод больше не используется, так как функционал отчетов
    # был перенесен в отдельный модуль. Метод оставлен для обратной
    # совместимости и будет удален в следующих версиях.
    #
    # @deprecated Используйте Reports::Generator вместо этого метода
    def create_reports(*)
      warn 'DEPRECATED: Метод create_reports устарел и будет удален. Используйте Reports::Generator.'
    end

    private

    def test_solution(task, solution_file)
      test_file = "tasks/#{task}-assert.rb"
      model = extract_model_from_file(solution_file)

      return false unless validate_files(task, test_file, solution_file, model)
      return false unless validate_solution_content(solution_file, model, task)

      run_tests(task, test_file, solution_file, model)
    end

    def extract_model_from_file(solution_file)
      File.basename(solution_file).split('-')[1..].join('-').sub('.rb', '')
    end

    def validate_files(task, test_file, solution_file, model)
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

      true
    end

    def validate_solution_content(solution_file, model, task)
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error '  ❌ Файл решения пуст'
        @report.save_result(model: model, task: task, success: false)
        return false
      end

      validate_syntax(solution_content, model, task)
    end

    def validate_syntax(solution_content, model, task)
      debug_log '  📝 Анализ синтаксиса решения...'
      temp_context = Module.new
      temp_context.module_eval(solution_content)
      debug_log '  ✅ Синтаксис решения корректен'
      true
    rescue SyntaxError => e
      error '  ❌ Ошибка синтаксиса в решении:'
      error "     #{e.message}"
      @report.save_result(model: model, task: task, success: false)
      false
    rescue StandardError => e
      warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при проверке синтаксиса:'
      warn "     #{e.class}: #{e.message}"
      warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
      true
    end

    def run_tests(task, test_file, solution_file, model)
      test_context = create_test_context(solution_file)
      test_content = File.read(test_file)

      debug_log '  🧪 Запуск тестов...'
      log_test_details(test_content, solution_file, test_context)

      result = execute_tests_in_thread(test_context, test_content, model, task)
      debug_log "  🎯 Результат выполнения: #{result.inspect}"
      success = handle_test_result(result, model, task)
      debug_log "  ✨ Финальный результат: #{success}"
      success
    rescue StandardError => e
      error "  ❌ Ошибка при чтении тестов: #{e.message}"
      @report.save_result(model: model, task: task, success: false)
      false
    end

    def create_test_context(solution_file)
      test_context = Module.new do
        include HumanEval::Assert
        include HumanEval::LogLevels

        class << self
          attr_accessor :log_level, :options
        end

        def self.handle_error(error)
          debug_log "Handling error: #{error.class} - #{error.message}"
          debug_log "Backtrace: #{error.backtrace&.join("\n")}"
          {
            status: :error,
            error: {
              class: error.class.name,
              message: error.message || 'Unknown error',
              backtrace: error.backtrace || []
            }
          }
        end
      end

      load_standard_libraries(test_context)
      load_solution(test_context, solution_file)
      configure_test_context(test_context)
      test_context
    end

    def load_standard_libraries(*)
      %w[prime set json date time base64 digest securerandom pathname].each do |lib|
        require lib
      rescue LoadError => e
        warn "  ⚠️ Библиотека #{lib} недоступна: #{e.message}"
      end
    end

    def load_solution(context, solution_file)
      solution_content = File.read(solution_file)
      context.module_eval(solution_content)
    rescue StandardError => e
      warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при загрузке в контекст тестов:'
      warn "     #{e.class}: #{e.message}"
      warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
    end

    def configure_test_context(context)
      context.log_level = @options[:log_level] || :normal
      context.options = @options.dup
    end

    def execute_tests_in_thread(test_context, test_content, model, task)
      result = Queue.new
      thread = Thread.new do
        run_tests_in_context(test_context, test_content, result, model, task)
      end

      thread.join(@timeout)
      if thread.alive?
        thread.kill
        error "  ❌ Тест превысил лимит времени (#{@timeout} секунд)"
        @report.save_result(model: model, task: task, success: false)
        return { status: :timeout }
      end

      result.pop
    end

    def run_tests_in_context(test_context, test_content, result, model, task)
      test_lines = test_content.split("\n")
      test_lines.each_with_index do |line, idx|
        next if line.strip.empty?

        line_number = idx + 1
        debug_log "     #{line_number}: #{line.strip}"

        begin
          test_context.module_eval(line)
        rescue HumanEval::Assert::AssertionError => e
          handle_assertion_error(e, line_number, line, model, task)
          result.push({ status: :error })
          break
        end
      end

      debug_log '  ✅ Тесты выполнены успешно'
      result.push({ status: :success })
      @report.save_result(model: model, task: task, success: true)
    rescue StandardError => e
      handle_test_error(e, model, task)
      result.push({ status: :error })
    end

    def handle_assertion_error(error, line_number, line, model, task)
      debug_log "\n  ❌ Тест не пройден на строке #{line_number}:"
      debug_log "     #{line.strip}"

      if error.expected && error.actual
        debug_log "     Ожидалось: #{error.expected.inspect}"
        debug_log "     Получено: #{error.actual.inspect}"
      end

      @report.save_result(model: model, task: task, success: false)
    end

    def handle_test_error(error, model, task)
      debug_log "  ❌ Ошибка при выполнении тестов: #{error.class} - #{error.message}"
      debug_log "  ❌ Ошибка: #{error.message || 'Unknown error'}"
      @report.save_result(model: model, task: task, success: false)
    end

    def handle_test_result(result, *, **)
      case result[:status]
      when :success
        true
      when :error
        log_error_details(result[:error]) if result[:error]
        false
      when :timeout
        false
      else
        error "  ❌ Неизвестный статус результата: #{result[:status]}"
        false
      end
    end

    def log_test_details(test_content, solution_file, test_context)
      debug_log '  📄 Содержимое теста:'
      debug_log test_content
      debug_log '  📄 Содержимое решения:'
      debug_log File.read(solution_file)
      debug_log '  🔍 Доступные методы в контексте:'
      debug_log test_context.methods.sort.inspect
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
      @report.results = @results
      @report.tasks = tasks
      @report.models = models

      # Генерируем отчеты
      @report.generate

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

    def run_all_model_tests(model)
      solutions = Dir.glob("tasks/t*-#{model}.rb")
      if solutions.empty?
        error "Решения для модели #{model} не найдены"
        return {}
      end

      tasks = extract_tasks(solutions)

      tasks.each do |t|
        solution = Dir.glob("tasks/#{t}-#{model}.rb").first
        next unless solution && File.exist?(solution)

        begin
          success = test_solution(t, solution)
          @results[t][model] = success || false
        rescue Interrupt
          error "Тест прерван для задачи #{t} модели #{model}"
          @results[t][model] = false
        end
      end

      display_results(tasks, [model])
    rescue Interrupt
      error "Отображение результатов прервано для модели #{model}"
    end

    def run_single_model_test(task, model)
      unless task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end

      solution = Dir.glob("tasks/#{task}-#{model}.rb").first
      if solution.nil? || !File.exist?(solution)
        error "Решение для задачи #{task} модели #{model} не найдено"
        return {}
      end

      begin
        success = test_solution(task, solution)
        @results[task][model] = success || false
      rescue Interrupt
        error "Тест прерван для задачи #{task} модели #{model}"
        @results[task][model] = false
      end

      display_results([task], [model])
    rescue Interrupt
      error "Отображение результатов прервано для задачи #{task} модели #{model}"
    end

    def calculate_model_stats
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
  end

  # Класс для обработки команд командной строки
  # @note Этот класс предоставляет интерфейс командной строки для запуска тестов
  # и управления отчетами через Thor
  class CLI < Thor
    package_name 'Test Runner'

    class_option :report_total,
                type: :boolean,
                default: false,
                desc: 'Показывать только общий отчет'
    class_option :log_level,
                type: :string,
                default: 'normal',
                desc: 'Уровень логирования (debug, normal, quiet)'

    desc 'all', 'Запустить все тесты'
    method_option :report_total,
                 type: :boolean,
                 default: false,
                 desc: 'Показывать только общий отчет'
    method_option :log_level,
                 type: :string,
                 default: 'normal',
                 desc: 'Уровень логирования (debug, normal, quiet)'
    def all
      runner = Runner.new(options)
      runner.run_all_tests
    end

    desc 'task TASK', 'Запустить тесты для конкретной задачи'
    method_option :report_total,
                 type: :boolean,
                 default: true,
                 desc: 'Показывать только общий отчет'
    method_option :log_level,
                 type: :string,
                 default: 'normal',
                 desc: 'Уровень логирования (debug, normal, quiet)'
    def task(task)
      runner = Runner.new(options)
      runner.run_task_tests(task)
    end

    desc 'model TASK MODEL', 'Запустить тесты для конкретной модели'
    method_option :report_total,
                 type: :boolean,
                 default: true,
                 desc: 'Показывать только общий отчет'
    method_option :log_level,
                 type: :string,
                 default: 'normal',
                 desc: 'Уровень логирования (debug, normal, quiet)'
    def model(task, model)
      runner = Runner.new(options)
      runner.run_model_tests(task, model)
    end

    def self.exit_on_failure?
      true
    end

    def self.start(given_args = ARGV, config = {})
      if ENV['RACK_ENV'] != 'test' && given_args.none? { |arg| arg.include?('report-total') }
        given_args << '--report-total'
      end
      super
    end
  end
end
