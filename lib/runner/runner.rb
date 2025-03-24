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
require_relative 'report_generator'

# Класс для запуска и управления тестами решений
module Runner
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    DONE_MARK = "\e[32m✓\e[0m".freeze # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m".freeze # Красный цвет

    def initialize(options = {})
      @options = options
      self.log_level = options[:log_level] || :normal
      @timeout = options[:timeout] || 5
      @generate_reports = options[:generate_reports] || false
      @results = {}
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
          success = test_solution(solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
        end
      end

      debug_log "Final results: #{@results.inspect}"

      # Генерируем отчеты только если это разрешено
      if @generate_reports
        report_data = {
          model_stats: model_stats,
          task_results: @results
        }

        HumanEval::ReportGenerator.new(report_data).generate_all
      end

      # display_total_console(tasks, models)
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
        success = test_solution(solution)
        @results[task][model] = success
      end

      display_results([task], models)
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
          display_results(tasks, [model])
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
          display_results([task], [model])
        rescue Interrupt
          error "Отображение результатов прервано для задачи #{task} модели #{model}"
        end
      end

      @results
    end

    def model_stats
      if @results.empty?
        run_all_tests
      end

      model_stats = {}
      solution_files = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }

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
        [model, percentage]
      end.sort_by { |model, percentage| [-percentage, model] }
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

    def test_solution(solution_file, model = nil)
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
      rescue SyntaxError => e
        log_error("Syntax error in #{solution_file}: #{e.message}")
        return false
      rescue StandardError => e
        log_error("Error in #{solution_file}: #{e.message}")
        return false
      end

      # test_file = solution_file.sub(/tasks\/(t\d+)-.*\.rb$/, 'spec/tmp/tasks/\1-assert.rb')
      # test_file = solution_file
      # unless File.exist?(test_file)
      #   log_error("Test file #{test_file} does not exist")
      #   return false
      # end

      begin
        load solution_file
        true
      rescue StandardError => e
        log_error("Error running test #{solution_file}: #{e.message}")
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

    # def display_total_console(tasks, models)
    #   rows = []
    #   # Используем простые названия моделей для заголовка
    #   rows << ['Задача'] + models
    #
    #   tasks.each do |task|
    #     row = [task]
    #     models.each do |model|
    #       row << (@results[task]&.fetch(model, false) ? DONE_MARK : FAIL_MARK)
    #     end
    #     rows << row
    #   end
    #
    #   # Добавляем строку с процентами
    #   percentages = models.map do |model|
    #     total = tasks.size
    #     passed = tasks.count { |task| @results[task]&.fetch(model, false) }
    #     percentage = total.zero? ? 0 : (passed * 100.0 / total).round(1)
    #     "#{percentage}%"
    #   end
    #   rows << ['%'] + percentages
    #
    #   table = Terminal::Table.new(
    #     title: "\nРезультаты тестирования\n",
    #     rows: rows,
    #     style: { border_x: '-', border_i: '+', alignment: :center }
    #   )
    #
    #   print table.to_s + "\n"
    # end

    def display_results(tasks, models)
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
  end
end
