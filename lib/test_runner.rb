require "terminal-table"
require "timeout"
require_relative "logger"
require_relative "assert"
require_relative "log_levels"

module TestRunner
  class Runner
    include HumanEval::Logger
    include HumanEval::LogLevels

    DONE_MARK = "\e[32m✓\e[0m"  # Зеленый цвет
    FAIL_MARK = "\e[31m✗\e[0m"  # Красный цвет

    def initialize(options = {})
      @options = options
      @results = {}
      self.log_level = @options[:log_level] || :normal
      @timeout = @options[:timeout] || 5  # Таймаут по умолчанию 5 секунд
    end

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then "\e[31m"    # Красный
              when 34..66 then "\e[33m"   # Желтый
              else "\e[32m"                # Зеленый
              end
      "#{color}#{text}\e[0m"
    end

    def run_all_tests
      if Dir.glob('tasks/t*-*.rb').empty?
        error "Ошибка: Не найдены файлы с решениями в директории tasks"
        return
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
    end

    def run_task_tests(task)
      unless task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return
      end
      test_file = "tasks/#{task}-assert.rb"
      unless File.exist?(test_file)
        error "Файл с тестами #{test_file} не найден"
        return
      end

      solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }.sort
      models = solutions.map { |s| File.basename(s).split('-')[1..-1].join('-').sub('.rb', '') }

      @results = Hash.new { |h, k| h[k] = {} }

      solutions.each do |solution|
        model = File.basename(solution).split('-')[1..-1].join('-').sub('.rb', '')
        success = test_solution(task, solution)
        @results[task][model] = success
      end

      display_results([task], models)
    end

    def run_model_tests(task, model)
      unless task.to_s.match?(/^t\d+$/)
        error "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
        return
      end

      unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
        error "Ошибка: Неверный формат названия модели"
        return
      end
      solution = Dir.glob("tasks/#{task}-#{model}.rb").first

      if solution.nil?
        error "Решение для задачи #{task} модели #{model} не найдено"
        return
      end

      @results[task] = {}
      success = test_solution(task, solution)
      @results[task][model] = success

      display_results([task], [model])
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
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл решения не найден: #{solution_file}"
        return false
      end
      
      unless File.exist?(test_file)
        error "\nРешение #{File.basename(solution_file)}:"
        error "  ❌ Файл тестов не найден: #{test_file}"
        return false
      end

      log "Решение #{File.basename(solution_file)}"
      
      # Проверяем на пустой файл
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        error "  ❌ Файл решения пуст"
        return false
      end
      
      begin
        debug_log "  📝 Анализ синтаксиса решения..."
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        debug_log "  ✅ Синтаксис решения корректен"
      rescue SyntaxError => e
        error "  ❌ Ошибка синтаксиса в решении:"
        error "     #{e.message}"
        return false
      rescue => e
        # Если в решении есть посторонний код, который вызывает ошибку,
        # логируем ошибку, но продолжаем выполнение
        warn "  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при проверке синтаксиса:"
        warn "     #{e.class}: #{e.message}"
        warn "     Тесты могут не пройти из-за отсутствия необходимых методов"
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
        
        begin
          module_eval(solution_content)
        rescue => e
          # Если в решении есть посторонний код, который вызывает ошибку,
          # логируем ошибку, но продолжаем выполнение тестов
          warn "  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при загрузке в контекст тестов:"
          warn "     #{e.class}: #{e.message}"
          warn "     Тесты могут не пройти из-за отсутствия необходимых методов"
        end
        
        extend self
      end
      
      test_context.log_level = @options[:log_level] || :normal
      
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
            test_context.log_level = @options[:log_level] || :normal
            test_context.options = @options.dup  # Добавляем .dup чтобы избежать проблем с разделяемыми объектами
            
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
              
              debug_log "  ✅ Тесты выполнены успешно"
              result.push({status: :success})
            rescue StandardError => e
              debug_log "  ❌ Ошибка при выполнении тестов: #{e.class} - #{e.message}"
              debug_log "  ❌ Ошибка: #{e.message || "Unknown error"}"
              result.push(test_context.handle_error(e))
            rescue Exception => e
              debug_log "  ❌ Критическая ошибка при выполнении тестов: #{e.class} - #{e.message}"
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
            debug_log "  ❌ Ошибка в тестовом потоке: #{e.class} - #{e.message}"
            result.push({
              status: :error,
              error: {
                class: e.class.name,
                message: e.message || "Unknown error",
                backtrace: e.backtrace || []
              }
            })
          rescue Exception => e
            debug_log "  ❌ Критическая ошибка в тестовом потоке: #{e.class} - #{e.message}"
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
              debug_log "  ❌ Тест не пройден:"
              debug_log "     #{error[:class]}: #{error[:message]}"
              debug_log "     Стек вызовов:"
              if error[:backtrace]&.any?
                error[:backtrace].each { |line| debug_log "       #{line}" }
              else
                debug_log "       Стек вызовов недоступен"
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
          error "     Возможно, в решении есть бесконечный цикл"
          return false
        ensure
          thread.kill unless thread.nil? || !thread.alive?
        end
      rescue Interrupt => e
        error "\n  ⚠️  Тест прерван пользователем (Ctrl+C)"
        debug_log "  📍 Место прерывания: #{e.backtrace.first}"
        return false
      rescue NoMethodError => e
        error "  ❌ Ошибка в тесте: попытка вызвать метод у nil"
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue NameError => e
        error "  ❌ Ошибка в тесте: неопределенная переменная или метод"
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue RegexpError => e
        error "  ❌ Ошибка в регулярном выражении:"
        error "     #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue StandardError => e
        error "  ❌ Неожиданная ошибка:"
        error "     Тип: #{e.class}"
        error "     Сообщение: #{e.message}"
        debug_log "     Место ошибки: #{e.backtrace.first}"
        debug_log "     Полный стек вызовов:"
        e.backtrace.each { |line| debug_log "       #{line}" }
        return false
      rescue Exception => e
        error "  ❌ Критическая ошибка:"
        error "     Тип: #{e.class}"
        error "     Сообщение: #{e.message}"
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
      # Всегда создаем оба отчета
      create_reports(tasks, models)
      
      # Выводим total отчет в консоль
      display_total_console(tasks, models)
      
      # Если не запрошен только total отчет, выводим также детальный отчет в консоль
      unless @options[:report_total]
        display_detailed_console(tasks, models)
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
      Dir.mkdir('reports') unless Dir.exist?('reports')
      
      # Сохраняем total отчет
      total_report_file = File.join('reports', "human_watch_ruby_report_total.md")
      File.open(total_report_file, 'w') do |file|
        model_stats.each do |model, percentage|
          file.puts "#{model}: #{percentage}%"
        end
      end
      
      # Сохраняем подробный отчет
      full_report_file = File.join('reports', "human_watch_ruby_report_full.md")
      File.open(full_report_file, 'w') do |file|
        file.puts "# Отчет о тестировании моделей"
        file.puts
        file.puts "Дата: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
        file.puts
        file.puts "## Результаты"
        file.puts
        file.puts "| Модель | Успешность |"
        file.puts "|--------|------------|"
        
        model_stats.each do |model, percentage|
          file.puts "| #{model} | #{percentage}% |"
        end
        
        file.puts
        file.puts "## Детальная информация"
        file.puts
        file.puts "Всего задач: #{tasks.size}"
        file.puts
        
        # Добавляем детальную информацию по каждой задаче
        file.puts "### Результаты по задачам"
        file.puts
        file.puts "| Задача | " + models.join(" | ") + " |"
        file.puts "|--------|" + models.map { |_| "----------" }.join("|") + "|"
        
        tasks.each do |task|
          row = "| #{task} |"
          models.each do |model|
            status = @results[task][model]
            row += " #{status ? '✓' : '✗'} |"
          end
          file.puts row
        end
      end
      
      puts "\nОтчеты сохранены в файлах:"
      puts "- Суммарный отчет: #{total_report_file}"
      puts "- Подробный отчет: #{full_report_file}"
    end
  end
end 
