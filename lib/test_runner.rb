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

      log "\nРешение #{File.basename(solution_file)}:"
      
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
        
        module_eval(solution_content)
        extend self
      end
      
      test_context.log_level = @options[:log_level] || :normal
      
      begin
        test_content = File.read(test_file)
        log "  🧪 Запуск тестов..."
        debug_log "  📄 Содержимое теста:"
        debug_log test_content
        debug_log "  📄 Содержимое решения:"
        debug_log solution_content
        debug_log "  🔍 Доступные методы в контексте:"
        debug_log test_context.methods.sort.inspect
        
        test_context.module_eval(test_content)
        log "  ✅ Все тесты пройдены успешно"
        return true
      rescue Timeout::Error
        error "  ❌ Превышен лимит времени выполнения (10 секунд)"
        return false
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
      rescue HumanEval::Assert::AssertionError => e
        error "  ❌ Тест не пройден:"
        error "     #{e.message}"
        if e.expected && e.actual
          error "     Ожидалось: #{e.expected.inspect}"
          error "     Получено: #{e.actual.inspect}"
        end
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

    def display_results(tasks, models)
      debug_log "Display results called with tasks: #{tasks.inspect} and models: #{models.inspect}"
      debug_log "Current results: #{@results.inspect}"
      
      rows = []
      model_scores = Hash.new(0)
      total_tasks = tasks.size

      tasks.each do |task|
        row = [task]
        models.each do |model|
          status = @results[task][model]
          debug_log "Status for task #{task}, model #{model}: #{status.inspect}"
          row << (status ? DONE_MARK : FAIL_MARK)
          model_scores[model] += 1 if status
        end
        rows << row
      end

      debug_log "Model scores: #{model_scores.inspect}"
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
  end
end 
