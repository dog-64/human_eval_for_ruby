# frozen_string_literal: true

require 'timeout'
require_relative 'assert'
require_relative 'human_eval/log_levels'
require_relative 'human_eval/logger'
require 'shellwords'
require 'fileutils'
require_relative 'human_eval/solver'
require_relative 'human_eval/reports'

module TestRunner
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    DONE_MARK = "\e[32m✓\e[0m"  # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m"  # Красный цвет

    def initialize(options = {})
      @options = options
      @results = {}
      self.log_level = parse_log_level(@options[:log_level])
      @timeout = @options[:timeout] || 5  # Таймаут по умолчанию 5 секунд
      @base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end

    def parse_log_level(level)
      case level&.to_s&.downcase
      when 'debug' then DEBUG
      when 'info' then INFO
      when 'warning' then WARNING
      when 'error' then ERROR
      else INFO
      end
    end

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then "\e[31m"    # Красный
              when 34..66 then "\e[33m"   # Желтый
              else "\e[32m"                # Зеленый
              end
      "#{color}#{text}\e[0m"
    end

    def validate_path(path)
      expanded_path = File.expand_path(path)
      unless expanded_path.start_with?(@base_dir)
        raise SecurityError, "Попытка доступа к файлу вне рабочей директории: #{path}"
      end
      expanded_path
    end

    def run_all_tests
      if Dir.glob('tasks/t*-*.rb').empty?
        error_log "Ошибка: Не найдены файлы с решениями в директории tasks"
        return {}
      end
      # Находим все файлы с решениями в директории tasks
      solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }
      tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort
      debug_log "Tasks: #{tasks.inspect}"

      models = solutions.map do |f|
        filename = File.basename(f)
        next if filename.end_with?('_asserts.rb')
        filename.split('-')[1..-1].join('-').sub('.rb', '')
      end.compact.uniq.sort
      debug_log "Models: #{models.inspect}"

      @results = Hash.new { |h, k| h[k] = {} }

      tasks.each do |task|
        task_solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }
        debug_log "Processing task #{task} with solutions: #{task_solutions.inspect}"
        
        task_solutions.each do |solution|
          model = File.basename(solution).split('-')[1..-1].join('-').sub('.rb', '')
          debug_log "Testing solution #{solution} for model #{model}"
          success = test_solution(task, solution)
          debug_log "Test result for #{model}: #{success}"
          @results[task][model] = success
        end
        debug_log "Results after task #{task}: #{@results.inspect}"
      end

      debug_log "Final results: #{@results.inspect}"
      display_results(tasks, models)
      @results
    end

    def run_task_tests(task)
      unless task.to_s.match?(/^t\d+$/)
        error_log "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end
      test_file = "tasks/#{task}-assert.rb"
      unless File.exist?(test_file)
        error_log "Файл с тестами #{test_file} не найден"
        return {}
      end

      solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }.sort
      models = solutions.map { |s| File.basename(s).split('-')[1..-1].join('-').sub('.rb', '') }

      @results = {}
      @results[task] = {}

      solutions.each do |solution|
        model = File.basename(solution).split('-')[1..-1].join('-').sub('.rb', '')
        success = test_solution(task, solution)
        @results[task][model] = success
      end

      display_results([task], models)
      @results
    end

    def run_model_tests(task, model)
      unless task.to_s.match?(/^t\d+$/)
        error_log "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return {}
      end

      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error_log "Ошибка: Неверный формат названия модели"
        return {}
      end
      solution = Dir.glob("tasks/#{task}-#{model}.rb").first

      if solution.nil?
        error_log "Решение для задачи #{task} модели #{model} не найдено"
        return {}
      end

      @results = {}
      @results[task] = {}
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
        filename.split('-')[1..-1].join('-').sub('.rb', '')
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
        error_log "\nРешение #{File.basename(solution_file)}:"
        error_log "  ❌ Файл решения не найден: #{solution_file}"
        return false
      end
      
      unless File.exist?(test_file)
        error_log "\nРешение #{File.basename(solution_file)}:"
        error_log "  ❌ Файл тестов не найден: #{test_file}"
        return false
      end

      info_log "Решение #{File.basename(solution_file)}"
      
      # Проверяем на пустой файл
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error_log "  ❌ Файл решения пуст"
        return false
      end
      
      begin
        debug_log "  📝 Анализ синтаксиса решения..."
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        debug_log "  ✅ Синтаксис решения корректен"
      rescue SyntaxError => e
        error_log "  ❌ Ошибка синтаксиса в решении:"
        error_log "     #{e.message}"
        return false
      end

      test_context = Module.new do
        include HumanEval::Assert
        include HumanEval::LogLevels
        
        def self.log_level=(level)
          @log_level = level
        end
        
        def self.log_level
          @log_level
        end
        
        def self.options=(opts)
          @options = opts
        end

        def self.options
          @options
        end

        def self.handle_error(e)
          debug_log "Handling error: #{e.class} - #{e.message}"
          debug_log "Backtrace: #{e.backtrace&.join("\n")}"
          {
            status: :error,
            error: {
              class: e.class.name,
              message: e.message || "Unknown error",
              backtrace: e.backtrace || []
            }
          }
        end
        
        module_eval(solution_content)
        extend self
      end
      
      test_context.log_level = parse_log_level(@options[:log_level])
      
      begin
        test_content = File.read(test_file)
        debug_log "  🧪 Запуск тестов..."
        debug_log "  📄 Содержимое теста:"
        debug_log test_content
        debug_log "  📄 Содержимое решения:"
        debug_log solution_content
        debug_log "  🔍 Доступные методы в контексте:"
        debug_log test_context.methods.sort.inspect

        result = Queue.new
        thread = Thread.new do
          begin
            # Создаем новый контекст для каждого теста
            test_context = Module.new do
              include HumanEval::Assert
              include HumanEval::LogLevels
              
              def self.log_level=(level)
                @log_level = level
              end
              
              def self.log_level
                @log_level
              end

              def self.options=(opts)
                @options = opts
              end

              def self.options
                @options
              end

              def self.handle_error(e)
                debug_log "Handling error: #{e.class} - #{e.message}"
                debug_log "Backtrace: #{e.backtrace&.join("\n")}"
                {
                  status: :error,
                  error: {
                    class: e.class.name,
                    message: e.message || "Unknown error",
                    backtrace: e.backtrace || []
                  }
                }
              end
            end
            
            test_context.module_eval(solution_content)
            test_context.extend(test_context)
            test_context.log_level = parse_log_level(@options[:log_level])
            test_context.options = @options.dup
            
            begin
              debug_log "  🔄 Выполняем тесты в контексте..."
              debug_log "  🔄 Выполняем тесты для #{File.basename(solution_file)}..."
              
              # Показываем и выполняем тесты по одному
              debug_log "  📝 Тесты:"
              test_lines = test_content.split("\n")
              test_lines.each_with_index do |line, idx|
                next if line.strip.empty?
                line_number = idx + 1
                debug_log "     #{line_number}: #{line.strip}"
                
                begin
                  test_context.module_eval(line)
                rescue HumanEval::Assert::AssertionError => e
                  # Сохраняем информацию о не пройденном тесте
                  model = File.basename(solution_file).split('-')[1..-1].join('-').sub('.rb', '')
                  task = File.basename(solution_file).split('-').first
                  
                  error_log "\n  ❌ Тест не пройден на строке #{line_number}:"
                  error_log "     #{line.strip}"
                  
                  if e.expected && e.actual
                    error_log "     Ожидалось: #{e.expected.inspect}"
                    error_log "     Получено: #{e.actual.inspect}"
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
              
              debug_log "  ✅ Тесты выполнены успешно"
              result.push({status: :success})
            rescue StandardError => e
              error_log "  ❌ Ошибка при выполнении тестов: #{e.class} - #{e.message}"
              error_log "  ❌ Ошибка: #{e.message || "Unknown error"}"
              result.push(test_context.handle_error(e))
            rescue Exception => e
              error_log "  ❌ Критическая ошибка при выполнении тестов: #{e.class} - #{e.message}"
              result.push({
                status: :error,
                error: {
                  class: e.class.name,
                  message: e.message || "Unknown error",
                  backtrace: e.backtrace || []
                }
              })
            end
          rescue StandardError => e
            error_log "  ❌ Ошибка в тестовом потоке: #{e.class} - #{e.message}"
            result.push({
              status: :error,
              error: {
                class: e.class.name,
                message: e.message || "Unknown error",
                backtrace: e.backtrace || []
              }
            })
          rescue Exception => e
            error_log "  ❌ Критическая ошибка в тестовом потоке: #{e.class} - #{e.message}"
            result.push({
              status: :error,
              error: {
                class: e.class.name,
                message: e.message || "Unknown error",
                backtrace: e.backtrace || []
              }
            })
          end
        end

        begin
          Timeout.timeout(@timeout) do
            debug_log "  ⏳ Ожидаем результат выполнения тестов..."
            res = result.pop
            debug_log "  📝 Получен результат: #{res.inspect}"
            case res[:status]
            when :success
              debug_log "  ✅ Все тесты пройдены успешно"
              return true
            when :error
              error = res[:error]
              error_log "  ❌ Тест не пройден:"
              error_log "     #{error[:class]}: #{error[:message]}"
              if error[:expected] && error[:actual]
                error_log "     Ожидалось: #{error[:expected].inspect}"
                error_log "     Получено: #{error[:actual].inspect}"
              end
              if error[:backtrace]&.any?
                debug_log "     Стек вызовов:"
                error[:backtrace].each { |line| debug_log "       #{line}" }
              end
              return false
            else
              error_log "  ❌ Неизвестный статус результата: #{res[:status]}"
              return false
            end
          end
        rescue Timeout::Error
          thread.kill
          thread.join(1)
          error_log "  ❌ Превышен лимит времени выполнения (#{@timeout} секунд)"
          error_log "     Возможно, в решении есть бесконечный цикл"
          return false
        ensure
          thread.kill unless thread.nil? || !thread.alive?
        end
      rescue Interrupt => e
        error_log "\n  ⚠️  Тест прерван пользователем (Ctrl+C)"
        debug_log "  📍 Место прерывания: #{e.backtrace.first}"
        return false
      rescue NoMethodError => e
        error_log "  ❌ Ошибка в тесте: попытка вызвать метод у nil"
        error_log "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue NameError => e
        error_log "  ❌ Ошибка в тесте: неопределенная переменная или метод"
        error_log "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue RegexpError => e
        error_log "  ❌ Ошибка в регулярном выражении:"
        error_log "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue StandardError => e
        error_log "  ❌ Неожиданная ошибка:"
        error_log "     Тип: #{e.class}"
        error_log "     Сообщение: #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue Exception => e
        error_log "  ❌ Критическая ошибка:"
        error_log "     Тип: #{e.class}"
        error_log "     Сообщение: #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
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
      puts "\nРезультаты тестирования:"
      model_stats.each do |model, percentage|
        puts "- #{model}: #{percentage}%"
      end
    end

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
      # Создаем только total отчет
      create_total_report(tasks, models)
      
      # Выводим total отчет в консоль
      display_total_console(tasks, models)
    end

    def create_total_report(tasks, models)
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
      reports_dir = validate_path('reports')
      Dir.mkdir(reports_dir) unless Dir.exist?(reports_dir)
      
      # Сохраняем total отчет
      total_report_file = validate_path(File.join('reports', "human_watch_ruby_report_total.md"))
      File.open(total_report_file, 'w') do |file|
        model_stats.each do |model, percentage|
          file.puts "#{model}: #{percentage}%"
        end
      end
      
      puts "\nРезультаты тестов сохранены в reports/results.json"
    end

    def create_reports(tasks, models)
      create_total_report(tasks, models)
    end
  end
end 
