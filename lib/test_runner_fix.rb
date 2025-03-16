#!/usr/bin/env ruby

# Этот файл содержит исправление для обработки ошибок в методе test_solution
# Добавьте следующий код в файл lib/test_runner.rb в метод test_solution
# в блоке thread = Thread.new do ... end
# перед строкой test_context.module_eval(solution_content)

=begin
            begin
              test_context.module_eval(solution_content)
              test_context.extend(test_context)
            rescue => e
              # Если в решении есть посторонний код, который вызывает ошибку,
              # логируем ошибку, но продолжаем выполнение тестов
              warn "  ⚠️ Предупреждение: в решении есть код, вызывающий ошибку при загрузке в контекст тестов:"
              warn "     #{e.class}: #{e.message}"
              warn "     Тесты могут не пройти из-за отсутствия необходимых методов"
              
              # Возвращаем результат с ошибкой
              result.push({
                status: :error,
                message: "Ошибка при загрузке решения: #{e.message}",
                passed: false,
                error: {
                  class: e.class.name,
                  message: e.message,
                  backtrace: e.backtrace || []
                }
              })
              Thread.exit
            end
=end 