# frozen_string_literal: true

require 'terminal-table'
require 'timeout'
require_relative 'human_eval/logger'
require_relative 'human_eval/assert'
require_relative 'human_eval/log_levels'
require 'shellwords'
require 'fileutils'
require_relative 'human_eval/solver'
require_relative 'human_eval/report_generator'

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
      
      HumanEval::ReportGenerator.new(report_data).generate_all
      
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

      @results = Hash.new { |h, k| h[k] = {} }
      success = test_solution(task, solution)
      @results[task][model] = success

      display_results([task], [model])
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

    private

    def test_solution(task, solution_file)
      test_file = "tasks/#{task}-assert.rb"

      return false unless validate_files(solution_file, test_file)
      return false unless validate_solution_content(solution_file)
      return false unless validate_solution_syntax(solution_file)

      run_tests(task, solution_file, test_file)
    end

    private

    def validate_files(solution_file, test_file)
      unless File.exist?(solution_file)
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл решения не найден: #{solution_file}"
        return false
      end

      unless File.exist?(test_file)
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл тестов не найден: #{test_file}"
        return false
      end

      true
    end

    def validate_solution_content(solution_file)
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error '  ❌ Файл решения пуст'
        return false
      end
      true
    end

    def validate_solution_syntax(solution_file)
      solution_content = File.read(solution_file)
      begin
        debug_log '  📝 Анализ синтаксиса решения...'
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        debug_log '  ✅ Синтаксис решения корректен'
        true
      rescue SyntaxError => e
        handle_syntax_error(e)
      rescue StandardError => e
        handle_validation_error(e)
      end
    end

    def handle_syntax_error(e)
      error '  ❌ Ошибка синтаксиса в решении:'
      error "     #{e.message}"
      false
    end

    def handle_validation_error(e)
      warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при проверке синтаксиса:'
      warn "     #{e.class}: #{e.message}"
      warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
      true
    end

    def create_test_context
      Module.new do
        include HumanEval::Assert
        include HumanEval::LogLevels

        class << self
          attr_accessor :log_level, :options

          def handle_error(e)
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

        extend self
      end
    end

    def run_tests(task, solution_file, test_file)
      test_context = create_test_context
      test_context.log_level = @options[:log_level] || :normal

      begin
        test_content = File.read(test_file)
        solution_content = File.read(solution_file)
        log_test_info(test_content, solution_content, test_context)

        result = Queue.new
        thread = Thread.new { execute_tests(result, solution_content, test_content) }

        handle_test_execution(thread, result)
      rescue Interrupt => e
        handle_interrupt(e)
      rescue NoMethodError => e
        handle_no_method_error(e)
      rescue NameError => e
        handle_name_error(e)
      rescue RegexpError => e
        handle_regexp_error(e)
      rescue StandardError => e
        handle_standard_error(e)
      rescue Exception => e
        handle_critical_error(e)
      end
    end

    def handle_no_method_error(e)
      error '  ❌ Ошибка в тесте: попытка вызвать метод у nil'
      error "     #{e.message}"
      log_error_backtrace(e)
      false
    end

    def handle_name_error(e)
      error '  ❌ Ошибка в тесте: неопределенная переменная или метод'
      error "     #{e.message}"
      log_error_backtrace(e)
      false
    end

    def handle_regexp_error(e)
      error '  ❌ Ошибка в регулярном выражении:'
      error "     #{e.message}"
      log_error_backtrace(e)
      false
    end

    def log_error_backtrace(e)
      debug_log "     Место ошибки: #{e.backtrace.first}"
      debug_log '     Полный стек вызовов:'
      e.backtrace.each { |line| debug_log "       #{line}" }
    end

    def handle_assertion_error(e, line_number, line)
      debug_log "\n  ❌ Тест не пройден на строке #{line_number}:"
      debug_log "     #{line.strip}"

      if e.expected && e.actual
        debug_log "     Ожидалось: #{e.expected.inspect}"
        debug_log "     Получено: #{e.actual.inspect}"
      end

      {
        status: :error,
        error: {
          class: e.class.name,
          message: e.message,
          expected: e.expected,
          actual: e.actual,
          line: line_number,
          test: line.strip
        }
      }
    end

    def log_test_info(test_content, solution_content, test_context)
      debug_log '  🧪 Запуск тестов...'
      debug_log '  📄 Содержимое теста:'
      debug_log test_content
      debug_log '  📄 Содержимое решения:'
      debug_log solution_content
      debug_log '  🔍 Доступные методы в контексте:'
      debug_log test_context.methods.sort.inspect
    end

    def execute_tests(result, solution_content, test_content)
      test_context = create_test_context
      test_context.module_eval(solution_content)
      test_context.extend(test_context)
      test_context.log_level = @options[:log_level] || :normal
      test_context.options = @options.dup

      run_test_lines(test_content, test_context, result)
    end

    def run_test_lines(test_content, test_context, result)
      debug_log '  📝 Тесты:'
      test_lines = test_content.split("\n")
      
      test_lines.each_with_index do |line, idx|
        next if line.strip.empty?
        
        begin
          test_context.module_eval(line)
        rescue HumanEval::Assert::AssertionError => e
          result.push(handle_assertion_error(e, idx + 1, line))
          return false
        end
      end

      debug_log '  ✅ Тесты выполнены успешно'
      result.push({ status: :success })
    rescue StandardError => e
      result.push(test_context.handle_error(e))
    end

    def handle_test_execution(thread, result)
      Timeout.timeout(@timeout) do
        debug_log '  ⏳ Ожидаем результат выполнения тестов...'
        res = result.pop
        process_test_result(res)
      end
    rescue Timeout::Error
      handle_timeout(thread)
    ensure
      thread.kill if thread&.alive?
    end

    def process_test_result(res)
      debug_log "   Получен результат: #{res.inspect}"
      case res[:status]
      when :success
        debug_log '  ✅ Все тесты пройдены успешно'
        true
      when :error
        log_error_details(res[:error])
        false
      else
        error "  ❌ Неизвестный статус результата: #{res[:status]}"
        false
      end
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

    end

    def handle_timeout(thread)
      thread.kill
      thread.join(1)
      error "  ❌ Превышен лимит времени выполнения (#{@timeout} секунд)"
      error '     Возможно, в решении есть бесконечный цикл'
      false
    end

    def handle_interrupt(e)
      error "\n  ⚠️  Тест прерван пользователем (Ctrl+C)"
      debug_log "  📍 Место прерывания: #{e.backtrace.first}"
      false
    end

    def handle_standard_error(e)
      error '  ❌ Неожиданная ошибка:'
      error "     Тип: #{e.class}"
      error "     Сообщение: #{e.message}"
      log_error_backtrace(e)
      false
    end

    def handle_critical_error(e)
      error '  ❌ Критическая ошибка:'
      error "     Тип: #{e.class}"
      error "     Сообщение: #{e.message}"
      log_error_backtrace(e)
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

      # Выводим в консоль в простом формате
      puts 'Результат прогона тестов:'
      model_stats.each do |model, percentage|
        puts "- #{model} - #{percentage}%"
      end
    end

    # Метод не используется, можно удалить
    def display_detailed_console(tasks, models)
      # Существующий код для детального отчета
      rows = []
      model_scores = Hash.new(0)
      total_tasks = tasks.size

      tasks.each do |task|
        row = [task]
        models.each do |model|
          status = @results[task][model]
          row << (status ? DONE_MARK : FAIL_MARK)
          model_scores[model] += 1 if status
        end
        rows << row
      end

      # Добавляем строку с итоговыми оценками
      score_row = ['Score']
      models.each do |model|
        percentage = (model_scores[model] * 100.0 / total_tasks).round
        score_row << colorize("#{percentage}%", percentage)
      end
      rows << :separator
      rows << score_row

      table = Terminal::Table.new do |t|
        t.headings = ['Task'] + models
        t.rows = rows
        t.style = {
          alignment: :center,
          padding_left: 1,
          padding_right: 1
        }
      end

      puts table
    end

    def display_results(tasks, models)
      # Всегда создаем оба отчета
      create_reports(tasks, models)

      # Выводим только суммарный отчет в консоль
      display_total_console(tasks, models)
    end

    # Получает информацию о модели из константы MODELS
    # @param model_key [String] ключ модели
    # @return [Hash] информация о модели или хеш с именем модели, если модель не найдена
    def get_model_info(model_key)
      # Проверяем доступность константы MODELS
      if defined?(HumanEval::SolverClass::MODELS)
        model_info = HumanEval::SolverClass::MODELS[model_key]
        return model_info if model_info
      end
      # Если модель не найдена, возвращаем хеш с именем модели
      { name: model_key, provider: 'unknown' }
    end

    # Получает отображаемое имя модели
    # @param model_key [String] ключ модели
    # @return [String] отображаемое имя модели
    def get_display_model_name(model_key)
      model_info = get_model_info(model_key)
      name = model_info[:name]
      provider = model_info[:provider]

      if provider && provider != 'unknown'
        "#{name} (#{provider})"
      else
        model_key # Используем ключ как имя, если не удалось получить информацию
      end
    end

    def create_reports(tasks, models)
      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, percentage| -percentage }

      # Создаем каталог reports, если он не существует
      FileUtils.mkdir_p('reports')

      # Путь к отчетам
      total_report_file = File.join('reports', 'human_eval_for_ruby_report_total.html')
      full_report_file = File.join('reports', 'human_eval_for_ruby_report_full.html')

      # Общий HTML заголовок и стили для обоих отчетов
      html_header = generate_html_header

      # Генерируем суммарный отчет в HTML
      File.open(total_report_file, 'w') do |file|
        file.puts html_header
        file.puts '<h1>Суммарный отчет о тестировании моделей</h1>'
        file.puts "<p>Дата: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}</p>"

        file.puts "<div class='model-results'>"
        file.puts '<table>'
        file.puts '<tr><th>Модель</th><th>Успешность</th></tr>'

        model_stats.each do |model, percentage|
          display_name = get_display_model_name(model)
          file.puts "<tr><td>#{add_soft_hyphens(display_name)}</td><td>#{percentage}%</td></tr>"
        end

        file.puts '</table>'
        file.puts '</div>'
        file.puts '</body></html>'
      end

      # Подсчитываем статистику для каждой задачи
      task_stats = tasks.map do |task|
        total_models = models.size
        passed_models = models.count { |model| @results[task][model] }
        percentage = (passed_models * 100.0 / total_models).round
        [task, percentage]
      end

      # Генерируем детальный отчет в HTML
      File.open(full_report_file, 'w') do |file|
        file.puts html_header
        file.puts '<h1>Отчет о тестировании моделей</h1>'
        file.puts "<p>Дата: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}</p>"

        file.puts '<h2>Результаты</h2>'

        # Таблица результатов моделей
        file.puts '<h3>Результаты по моделям</h3>'
        file.puts "<div class='model-results'>"
        file.puts '<table>'
        file.puts '<tr><th>Модель</th><th>Успешность</th></tr>'

        model_stats.each do |model, percentage|
          display_name = get_display_model_name(model)
          file.puts "<tr><td>#{add_soft_hyphens(display_name)}</td><td>#{percentage}%</td></tr>"
        end

        file.puts '</table>'
        file.puts '</div>'

        file.puts '<h2>Детальная информация</h2>'
        file.puts "<p>Всего задач: #{tasks.size}</p>"
        file.puts "<p>Всего моделей: #{models.size}</p>"

        # Детальная таблица по задачам и моделям
        file.puts '<h3>Результаты по задачам и моделям</h3>'
        file.puts "<div class='task-results'>"
        file.puts '<table>'

        # Заголовок таблицы
        file.puts '<tr><th>Задача</th>'
        file.puts '<th>Успешность</th>'
        models.each do |model|
          display_name = get_display_model_name(model)
          file.puts "<th>#{add_soft_hyphens(display_name)}</th>"
        end
        file.puts '</tr>'

        # Строки таблицы с данными
        tasks.each do |task|
          file.puts "<tr><td><a href='../tasks/#{task}.md'>#{task}</a></td>"

          # Добавляем процент успешности для задачи сразу после названия задачи
          task_percentage = task_stats.find { |t, _| t == task }[1]
          color_class = if task_percentage == 100
                          'success'
                        elsif task_percentage.zero?
                          'failure'
                        else
                          ''
                        end
          file.puts "<td class='#{color_class}'>#{task_percentage}%</td>"

          models.each do |model|
            status = @results[task][model]
            css_class = status ? 'success' : 'failure'
            symbol = status ? '✓' : '✗'
            file.puts "<td class='#{css_class}'>#{symbol}</td>"
          end

          file.puts '</tr>'
        end

        file.puts '</table>'
        file.puts '</div>'
        file.puts '</body></html>'
      end
    end

    # Генерирует HTML-заголовок с CSS-стилями
    # @return [String] HTML-заголовок с CSS
    def generate_html_header
      <<~HTML
        <!DOCTYPE html>
        <html lang="ru">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Отчет о тестировании моделей</title>
          <link rel="stylesheet" href="style.css">
        </head>
        <body>
      HTML
    end

    # Форматирует название модели с мягкими переносами
    # @param model [String] название модели
    # @return [String] отформатированное название с мягкими переносами
    def add_soft_hyphens(text)
      text.gsub('_', '_&shy;')
    end

    def find_solution_files(task = nil)
      pattern = task ? "tasks/#{task}-*.rb" : 'tasks/t*-*.rb'
      Dir.glob(pattern).reject { |f| f.end_with?('-assert.rb') }
    end
  end
end
