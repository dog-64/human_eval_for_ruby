require_relative "logger"
require_relative "log_levels"

module HumanEval
  module Assert
    include Logger
    include LogLevels

    class AssertionError < StandardError
      attr_reader :expected, :actual, :assertion_info

      def initialize(message, expected = nil, actual = nil, assertion_info = nil)
        super(message)
        @expected = expected
        @actual = actual
        @assertion_info = assertion_info
      end
    end

    def assert(condition, message = nil)
      debug_log "assert called with condition: #{condition.inspect}, message: #{message.inspect}"
      debug_log "condition class: #{condition.class}"
      debug_log "condition object_id: #{condition.object_id}"
      unless condition
        debug_log "condition is falsey"
        raise AssertionError.new(
          message || "Expected #{condition.inspect} to be truthy",
          nil,
          nil,
          "assert(#{condition.inspect})"
        )
      end
      debug_log "condition is truthy"
      true
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
      expected_float = Float(expected)
      actual_float = Float(actual)
      delta_float = Float(delta)
      
      unless (expected_float - actual_float).abs <= delta_float
        raise AssertionError.new(
          message || "Expected #{actual.inspect} to be within #{delta} of #{expected.inspect}",
          expected,
          actual,
          "assert_in_delta(#{expected.inspect}, #{actual.inspect}, #{delta.inspect})"
        )
      end
      true
    end

    def assert_raises(exception_class = StandardError)
      debug_log "assert_raises(#{exception_class.inspect})"
      begin
        yield
      rescue => e
        if e.is_a?(exception_class)
          return e
        else
          raise AssertionError.new(
            "Expected #{exception_class.inspect} but got #{e.class.inspect}",
            exception_class,
            e.class,
            "assert_raises(#{exception_class.inspect})"
          )
        end
      end
      raise AssertionError.new(
        "Expected #{exception_class.inspect} but nothing was raised",
        exception_class,
        nil,
        "assert_raises(#{exception_class.inspect})"
      )
    end

    def assert_valid_order(result, dependencies)
      dependencies.each do |pred, succ|
        pred_index = result.index(pred)
        succ_index = result.index(succ)
        raise "Неверный порядок сортировки" unless pred_index < succ_index
      end
    end

    def debug_assert(condition, message = nil)
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | debug_assert(#{condition}, #{message})"
      assert_result = condition
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | assert_result =#{assert_result.inspect}"
      
      assert(condition, message)
    end
  end
end 
