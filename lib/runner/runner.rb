require 'terminal-table'
require 'timeout'
require_relative '../human_eval/logger'
require_relative '../human_eval/assert'
require_relative '../human_eval/log_levels'
require 'shellwords'
require 'fileutils'
require_relative '../human_eval/solver'
require_relative '../human_eval/report_generator'
require_relative '../human_eval/reports/generator'

# Класс для запуска и управления тестами решений
module Runner
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    def initialize(options = {})
      @options = options
      self.log_level = options[:log_level] || :normal
      @timeout = options[:timeout] || 5
      @generate_reports = options[:generate_reports] || false
      @results = {}
    end

    def run_all_tests
      # Используем опции из инициализации класса
      tasks = find_solution_files.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort
      if tasks.empty?
        error 'Ошибка: Не найдены файлы с решениями'
        return {}
      end

      @results = Hash.new { |h, k| h[k] = {} }

      tasks.each do |task|
        task_solutions = find_solution_files(task)
        debug_log "Processing task #{task} with solutions: #{task_solutions.inspect}"

        task_solutions.each do |solution|
          model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
          debug_log "Testing solution #{solution} for model #{model}"
          success = test_solution(solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
        end
      end

      debug_log "Final results: #{@results.inspect}"

      # Генерируем отчеты только если это разрешено
      if @generate_reports
        model_stats = get_model_stats
        report_data = {
          model_stats: model_stats,
          task_results: @results
        }
        generator = HumanEval::ReportGenerator.new(report_data)
        generator.generate_all
      end

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

      # models = solutions.map { |s| File.basename(s).split('-')[1..].join('-').sub('.rb', '') }
      @results = Hash.new { |h, k| h[k] = {} }

      solutions.each do |solution|
        model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
        success = test_solution(solution)
        @results[task][model] = success
      end

      display_results
      @results
    end

    def run_model_tests(task, model)
      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error 'Ошибка: Неверный формат названия модели'
        return {}
      end

      @results = Hash.new { |h, k| h[k] = {} }

      if task.nil?
        # Если задача не указана, запускаем тесты для всех задач этой модели
        solutions = Dir.glob("tasks/t*-#{model}.rb")
        if solutions.empty?
          error "Решения для модели #{model} не найдены"
          return {}
        end

        tasks = solutions.map { |f| File.basename(f).split('-').first }.uniq.sort

        tasks.each do |t|
          solution = Dir.glob("tasks/#{t}-#{model}.rb").first
          next unless solution && File.exist?(solution)

          begin
            success = test_solution(solution)
            @results[t][model] = success || false
          rescue Interrupt
            error "Тест прерван для задачи #{t} модели #{model}"
            @results[t][model] = false
          end
        end

        begin
          display_results
        rescue Interrupt
          error "Отображение результатов прервано для модели #{model}"
        end
      else
        # Если задача указана, проверяем её формат и запускаем тест
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
          success = test_solution(solution)
          @results[task][model] = success || false
        rescue Interrupt
          error "Тест прерван для задачи #{task} модели #{model}"
          @results[task][model] = false
        end

        begin
          display_results
        rescue Interrupt
          error "Отображение результатов прервано для задачи #{task} модели #{model}"
        end
      end

      @results
    end

    def model_stats
      run_all_tests if @results.empty?

      model_stats = {}
      solution_files = find_solution_files

      solution_files.each do |file|
        if (m = file.match(/tasks\/t\d+-(.+)\.rb/))
          puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
          model = m[1]
          model_stats[model] ||= { total: 0, passed: 0 }
          model_stats[model][:total] += 1

          task = file.match(/tasks\/(t\d+)/)[1]
          model_stats[model][:passed] += 1 if @results[task]&.dig(model)
        end
      end

      # Преобразуем статистику в массив пар [модель, процент]
      model_stats.map do |model, stats|
        percentage = stats[:total].zero? ? 0 : (stats[:passed] * 100.0 / stats[:total]).round
        [model, { total: stats[:total], passed: stats[:passed], percentage: percentage }]
      end.sort_by { |_, stats| [-stats[:percentage], _] }
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
    # @deprecated Используйте ReportGenerator вместо этого метода
    def create_reports(*)
      warn 'DEPRECATED: Метод create_reports устарел и будет удален. Используйте ReportGenerator.'
      # Оставляем пустую реализацию
    end

    def log_error(message)
      error("\n#{message}")
    end

    private

    def test_solution(solution_file)
      unless File.exist?(solution_file)
        log_error("Solution file #{solution_file} does not exist")
        return false
      end
      content = File.read(solution_file)
      if content.strip.empty?
        log_error("Solution file #{solution_file} is empty")
        return false
      end

      begin
        eval(content)
        true
      rescue SyntaxError => e
        log_error("Syntax error in #{solution_file}: #{e.message}")
        false
      rescue StandardError => e
        log_error("Runtime error in #{solution_file}: #{e.message}")
        false
      rescue Exception => e
        log_error("Unexpected error in #{solution_file}: #{e.message}")
        false
      end
    end

    def display_results
      if @generate_reports
        report_generator = ReportGenerator.new(@results)
        report_generator.generate_reports
      end

      # display_total_console(tasks, models)
    end

    def get_model_info(model_key)
      # Проверяем доступность константы MODELS
      if defined?(HumanEval::SolverClass::MODELS)
        HumanEval::SolverClass::MODELS[model_key] || { name: model_key, provider: 'unknown' }
      else
        { name: model_key, provider: 'unknown' }
      end
    end

    def get_display_model_name(model_key)
      model_info = get_model_info(model_key)
      name = model_info[:name]
      provider = model_info[:provider]
      note = model_info[:note]

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

    def get_model_stats
      tasks = @results.keys
      models = @results.values.flat_map(&:keys).uniq

      models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, { total: total_tasks, passed: passed_tasks, percentage: percentage }]
      end.to_h
    end
  end
end
