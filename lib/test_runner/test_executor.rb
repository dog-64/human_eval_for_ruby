# frozen_string_literal: true

module TestRunner
  # Модуль для выполнения тестов
  module TestExecutor
    def run_tests(task, test_file, solution_file, model)
      test_context = create_test_context(solution_file)
      test_content = File.read(test_file)

      debug_log '  🧪 Запуск тестов...'
      debug_log "  📄 Содержимое теста:\n#{test_content}"
      debug_log "  📄 Содержимое решения:\n#{File.read(solution_file)}"
      debug_log "  🔍 Доступные методы в контексте:"
      debug_log test_context.methods.sort.inspect

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

    def test_solution(task, solution_file)
      test_file = "tasks/#{task}-assert.rb"
      unless File.exist?(test_file)
        error "Файл с тестами #{test_file} не найден"
        return false
      end

      debug_log "🔍 Тестирование решения: #{solution_file}"
      debug_log "📄 Файл с тестами: #{test_file}"
      model = extract_model_from_file(solution_file)
      debug_log "🤖 Модель: #{model}"
      
      result = run_tests(task, test_file, solution_file, model)
      debug_log "✨ Результат тестирования: #{result}"
      result
    rescue StandardError => e
      error "Ошибка при тестировании решения: #{e.message}"
      false
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

    private

    def create_test_context(solution_file)
      debug_log "  🔧 Создание контекста для тестов..."
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

      debug_log "  📚 Загрузка стандартных библиотек..."
      load_standard_libraries(test_context)
      
      debug_log "  📄 Загрузка решения..."
      load_solution(test_context, solution_file)
      
      debug_log "  ⚙️ Настройка контекста..."
      configure_test_context(test_context)
      
      debug_log "  ✅ Контекст создан успешно"
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
      debug_log "  📄 Содержимое решения:\n#{solution_content}"
      context.module_eval(solution_content)
    rescue StandardError => e
      warn '  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при загрузке в контекст тестов:'
      warn "     #{e.class}: #{e.message}"
      warn '     Тесты могут не пройти из-за отсутствия необходимых методов'
      raise
    end

    def configure_test_context(context)
      context.log_level = @options[:log_level] || :normal
      context.options = @options.dup
      debug_log "  ⚙️ Уровень логирования: #{context.log_level}"
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
      debug_log "  🧪 Запуск тестов в контексте..."
      test_lines = test_content.split("\n")
      success = true

      test_lines.each_with_index do |line, idx|
        next if line.strip.empty?

        line_number = idx + 1
        debug_log "     #{line_number}: #{line.strip}"

        begin
          test_context.module_eval(line)
          debug_log "     ✅ Тест на строке #{line_number} пройден"
        rescue HumanEval::Assert::AssertionError => e
          handle_assertion_error(e, line_number, line, model, task)
          success = false
          break
        rescue StandardError => e
          handle_test_error(e, model, task)
          success = false
          break
        end
      end

      if success
        debug_log '  ✅ Тесты выполнены успешно'
        @report.save_result(model: model, task: task, success: true)
        result.push({ status: :success })
      else
        result.push({ status: :error })
      end
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

    def handle_test_result(result, model, task)
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
  end
end 