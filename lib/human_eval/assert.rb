require_relative 'logger'
require_relative 'log_levels'

module HumanEval
  # Модуль Assert предоставляет набор методов для проверки условий и генерации ошибок
  # при невыполнении этих условий. Используется для написания тестов и проверки корректности
  # работы кода.
  module Assert
    include Logger
    include LogLevels

    # Исключение, генерируемое при нарушении условия проверки
    # Содержит информацию об ожидаемом и фактическом значениях,
    # а также детали о выполненной проверке
    class AssertionError < StandardError
      attr_reader :expected, :actual, :assertion_info

      def initialize(message, expected = nil, actual = nil, assertion_info = nil)
        super(message || 'Assertion failed')
        @expected = expected
        @actual = actual
        @assertion_info = assertion_info
      end
    end

    def assert(condition, message = nil)
      debug_log "assert called with condition: #{condition.inspect}, message: #{message.inspect}"

      begin
        result = condition.is_a?(Proc) ? condition.call : condition
        debug_log "assert result: #{result.inspect}"

        unless result
          raise AssertionError.new(
            message || "Expected #{condition.inspect} to be truthy",
            true,
            result,
            "assert(#{condition.inspect})"
          )
        end

        debug_log 'assertion passed'
        true
      rescue NoMethodError => e
        debug_log "Error in assert: #{e.class} - #{e.message}"
        debug_log "Backtrace: #{e.backtrace&.join("\n")}"
        raise AssertionError.new(
          "NoMethodError: #{e.message}",
          true,
          nil,
          "assert(...) - #{e.class}"
        )
      rescue ZeroDivisionError => e
        debug_log "Error in assert: #{e.class} - #{e.message}"
        debug_log "Backtrace: #{e.backtrace&.join("\n")}"
        raise AssertionError.new(
          "ZeroDivisionError: #{e.message}",
          true,
          nil,
          "assert(...) - #{e.class}"
        )
      rescue StandardError => e
        debug_log "Error in assert: #{e.class} - #{e.message}"
        debug_log "Backtrace: #{e.backtrace&.join("\n")}"
        raise AssertionError.new(
          "Error: #{e.message}",
          true,
          nil,
          "assert(...) - #{e.class}"
        )
      end
    end

    def assert_equal(expected, actual, message = nil)
      debug_log "assert_equal(#{expected.inspect}, #{actual.inspect}, #{message.inspect})"

      unless expected == actual
        raise AssertionError.new(
          message || "Expected #{actual.inspect} to equal #{expected.inspect}",
          expected,
          actual,
          "assert_equal(#{expected.inspect}, #{actual.inspect})"
        )
      end

      true
    end

    def assert_not_equal(expected, actual, message = nil)
      debug_log "assert_not_equal(#{expected.inspect}, #{actual.inspect}, #{message.inspect})"

      if expected == actual
        raise AssertionError.new(
          message || "Expected #{actual.inspect} to not equal #{expected.inspect}",
          expected,
          actual,
          "assert_not_equal(#{expected.inspect}, #{actual.inspect})"
        )
      end

      true
    end

    def assert_in_delta(expected, actual, delta, message = nil)
      debug_log "assert_in_delta(#{expected.inspect}, #{actual.inspect}, #{delta.inspect}, #{message.inspect})"

      begin
        expected_float = Float(expected)
        actual_float = Float(actual)
        delta_float = Float(delta)

        difference = (expected_float - actual_float).abs

        unless difference <= delta_float
          raise AssertionError.new(
            message || "Expected #{actual.inspect} to be within #{delta.inspect} of #{expected.inspect}, but difference was #{difference}",
            expected,
            actual,
            "assert_in_delta(#{expected.inspect}, #{actual.inspect}, #{delta.inspect})"
          )
        end

        true
      rescue ArgumentError => e
        debug_log "Error in assert_in_delta: #{e.class} - #{e.message}"
        raise AssertionError.new(
          "ArgumentError: #{e.message}",
          expected,
          actual,
          "assert_in_delta(...) - #{e.class}"
        )
      end
    end

    def assert_raises(exception_class = StandardError)
      debug_log "assert_raises(#{exception_class.inspect})"

      begin
        yield
      rescue exception_class => e
        debug_log "Expected exception raised: #{e.class} - #{e.message}"
        return e
      rescue StandardError => e
        debug_log "Unexpected exception raised: #{e.class} - #{e.message}"
        raise AssertionError.new(
          "Expected #{exception_class} but got #{e.class}",
          exception_class,
          e.class,
          "assert_raises(#{exception_class.inspect})"
        )
      end

      debug_log "No exception raised"
      raise AssertionError.new(
        "Expected #{exception_class} but nothing was raised",
        exception_class,
        nil,
        "assert_raises(#{exception_class.inspect})"
      )
    end

    def assert_valid_order(result, dependencies)
      dependencies.each do |pred, succ|
        pred_idx = result.index(pred)
        succ_idx = result.index(succ)
        next unless pred_idx && succ_idx

        unless pred_idx < succ_idx
          raise AssertionError.new('Неверный порядок сортировки')
        end
      end
    end

    def debug_assert(condition, message = nil)
      message_str = message.nil? ? "nil" : message
      puts "debug_assert(#{condition.inspect}, #{message_str})"
      assert(condition, message)
    end
  end
end
