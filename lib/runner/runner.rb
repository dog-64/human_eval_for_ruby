puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
require 'terminal-table'
require 'timeout'
require_relative '../human_eval/logger'
require_relative '../assert'
require_relative '../human_eval/log_levels'
require 'shellwords'
require 'fileutils'
require_relative '../human_eval/solver'
require_relative '../human_eval/reports/generator'
require_relative '../test_runner/report'

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
      @report = TestRunner::Report.new
    end

    def run_all_tests
      # Инициализируем результаты как вложенный хэш
      @results = Hash.new { |h, k| h[k] = {} }
      
      tasks = find_solution_files.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort
      if tasks.empty?
        error 'Ошибка: Не найдены файлы с решениями'
        return {}
      end

      tasks.each do |task|
        task_solutions = find_solution_files(task)
        debug_log "Processing task #{task} with solutions: #{task_solutions.inspect}"

        task_solutions.each do |solution|
          model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
          debug_log "Testing solution #{solution} for model #{model}"
          success = test_solution(solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
          @report.save_result(model: model, task: task, success: success)
        end
      end

      debug_log "Final results: #{@results.inspect}"

      # Генерируем отчеты только если это разрешено
      if @generate_reports
        stats = model_stats
        model_stats_hash = stats.to_h { |model, data| [model, data[:percentage]] }
        report_data = {
          model_stats: model_stats_hash,
          task_results: @results
        }
        generator = HumanEval::Reports::Generator.new(report_data)
        generator.generate
      end

      @results
    end

    def run_task_tests(task)
      # Инициализируем результаты как вложенный хэш
      @results = Hash.new { |h, k| h[k] = {} }
      
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

      solutions.each do |solution|
        model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
        success = test_solution(solution)
        @results[task][model] = success
        @report.save_result(model: model, task: task, success: success)
      end

      display_results
      @results
    end

    def run_model_tests(task, model)
      # Инициализируем результаты как вложенный хэш
      @results = Hash.new { |h, k| h[k] = {} }
      
      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error 'Ошибка: Неверный формат названия модели'
        return {}
      end

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
            @report.save_result(model: model, task: t, success: success || false)
          rescue Interrupt
            error "Тест прерван для задачи #{t} модели #{model}"
            @results[t][model] = false
            @report.save_result(model: model, task: t, success: false)
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
          @report.save_result(model: model, task: task, success: success || false)
        rescue Interrupt
          error "Тест прерван для задачи #{task} модели #{model}"
          @results[task][model] = false
          @report.save_result(model: model, task: task, success: false)
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

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then 31  # красный
              when 34..66 then 33 # желтый
              else 32            # зеленый
              end
      "\e[#{color}m#{text}\e[0m"
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
      task = File.basename(solution_file).split('-').first
      test_file = "tasks/#{task}-assert.rb"

      unless File.exist?(solution_file)
        debug_log "Файл решения не найден: #{solution_file}"
        return false
      end

      unless File.exist?(test_file)
        debug_log "Файл тестов не найден: #{test_file}"
        return false
      end

      # Создаем новый контекст для каждого теста
      test_context = Module.new
      test_context.extend(HumanEval::Assert)
      test_context.extend(HumanEval::LogLevels)
      test_context.extend(HumanEval::Logger)

      # Загружаем решение в контекст
      test_context.module_eval(File.read(solution_file))

      # Загружаем и выполняем тесты в том же контексте
      test_context.module_eval(File.read(test_file))

      true
    rescue StandardError => e
      debug_log "Ошибка в тесте #{task} (#{solution_file}): #{e.message}"
      false
    end

    def display_results
      if @generate_reports
        model_stats = get_model_stats
        report_data = {
          model_stats: model_stats,
          task_results: @results
        }
        generator = HumanEval::Reports::Generator.new(report_data)
        generator.generate
        generator.display_total_console
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
  end
end 