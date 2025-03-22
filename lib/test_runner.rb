# frozen_string_literal: true

require 'terminal-table'
require 'timeout'
require_relative 'logger'
require_relative 'assert'
require_relative 'log_levels'
require 'shellwords'
require 'fileutils'
require_relative 'human_eval_solver'
require_relative 'human_eval/report_generator'
require_relative 'human_eval/assert'

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

      # Проверяем на пустой файл
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error '  ❌ Файл решения пуст'
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
          rescue StandardError => e
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
              debug_log '  ❌ Тест не пройден:'
              debug_log "     #{error[:class]}: #{error[:message]}"
              debug_log '     Стек вызовов:'
              if error[:backtrace]&.any?
                error[:backtrace].each { |line| debug_log "       #{line}" }
              else
                debug_log '       Стек вызовов недоступен'
              end
              return false
            else
              error "  ❌ Неизвестный статус результата: #{res[:status]}"
              return false
            end
          end
        rescue Timeout::Error
          thread.kill
          thread.join(1) # Даем потоку секунду на завершение
          error "  ❌ Превышен лимит времени выполнения (#{@timeout} секунд)"
          error '     Возможно, в решении есть бесконечный цикл'
          false
        ensure
          thread.kill unless thread.nil? || !thread.alive?
        end
      rescue Interrupt => e
        error "\n  ⚠️  Тест прерван пользователем (Ctrl+C)"
        debug_log "  📍 Место прерывания: #{e.backtrace.first}"
        false
      rescue NoMethodError => e
        error '  ❌ Ошибка в тесте: попытка вызвать метод у nil'
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log '     Полный стек вызовов:'
        e.backtrace.each { |line| debug_log "       #{line}" }
        false
      rescue NameError => e
        error '  ❌ Ошибка в тесте: неопределенная переменная или метод'
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log '     Полный стек вызовов:'
        e.backtrace.each { |line| debug_log "       #{line}" }
        false
      rescue RegexpError => e
        error '  ❌ Ошибка в регулярном выражении:'
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log '     Полный стек вызовов:'
        e.backtrace.each { |line| debug_log "       #{line}" }
        false
      rescue StandardError => e
        error '  ❌ Неожиданная ошибка:'
        error "     Тип: #{e.class}"
        error "     Сообщение: #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log '     Полный стек вызовов:'
        e.backtrace.each { |line| debug_log "       #{line}" }
        false
      rescue Exception => e
        error '  ❌ Критическая ошибка:'
        error "     Тип: #{e.class}"
        error "     Сообщение: #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log '     Полный стек вызовов:'
        e.backtrace.each { |line| debug_log "       #{line}" }
        false
      end
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
          <style>
            body {
              font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
                           Helvetica, Arial, sans-serif;
              line-height: 1.6;
              max-width: 1200px;
              margin: 0 auto;
              padding: 20px;
              color: #333;
              hyphens: auto;
              word-wrap: break-word;
              overflow-wrap: break-word;
            }
            h1, h2, h3 {
              color: #2c3e50;
            }
            table {
              border-collapse: collapse;
              width: 100%;
              margin-bottom: 20px;
              font-size: 14px;
            }
            th, td {
              hyphens: auto;
              word-wrap: break-word;
              overflow-wrap: break-word;
              border: 1px solid #ddd;
              padding: 8px;
              text-align: center;
            }
            th {
              background-color: #f2f2f2;
              position: sticky;
              top: 0;
              vertical-align: top;
            }
            tr:nth-child(even) {
              background-color: #f9f9f9;
            }
            .success {
              color: #27ae60;
              font-weight: bold;
            }
            .failure {
              color: #e74c3c;
              font-weight: bold;
            }
            .model-results td:first-child {
              text-align: left;
              font-weight: bold;
            }
            .task-results td:first-child {
              text-align: left;
              font-weight: bold;
            }
            .task-results th {
              vertical-align: top;
            }
            @media (max-width: 768px) {
              table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
              }
            }
          </style>
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
