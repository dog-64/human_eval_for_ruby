# frozen_string_literal: true

require_relative "human_eval/log_levels"
require_relative "human_eval/logger"

module HumanEval
  module Assert
    include Logger
    include LogLevels

    class AssertionError < StandardError
      attr_reader :expected, :actual, :assertion_info

      def initialize(message, expected = nil, actual = nil, assertion_info = nil)
        super(message || "Assertion failed")
        @expected = expected
        @actual = actual
        @assertion_info = assertion_info
      end
    end

    def assert(condition, message = nil)
      debug_log "assert called with condition: #{condition.inspect}, message: #{message.inspect}"
      
      begin
        # Если condition это результат сравнения (например, a == b)
        result = condition
        debug_log "assert result: #{result.inspect}"
        
        unless result
          raise AssertionError.new(
            message || "Expected #{condition.inspect} to be truthy",
            true,
            result,
            "assert(#{condition.inspect})"
          )
        end
        
        debug_log "assertion passed"
        true
      rescue NoMethodError => e
        debug_log "NoMethodError in assert: #{e.message}"
        debug_log "Backtrace: #{e.backtrace&.join("\n")}"
        raise AssertionError.new(
          "NoMethodError: #{e.message}",
          true,
          nil,
          "assert(...) - NoMethodError"
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
        
        unless (expected_float - actual_float).abs <= delta_float
          raise AssertionError.new(
            message || "Expected #{actual.inspect} to be within #{delta} of #{expected.inspect}",
            expected,
            actual,
            "assert_in_delta(#{expected.inspect}, #{actual.inspect}, #{delta.inspect})"
          )
        end
        true
      rescue ArgumentError => e
        raise AssertionError.new(
          "Error: invalid value for Float(): #{e.message}",
          expected,
          actual,
          "assert_in_delta(#{expected.inspect}, #{actual.inspect}, #{delta.inspect})"
        )
      end
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
      puts "debug_assert(#{condition}, #{message.nil? ? 'nil' : message})"
      puts "assert_result = #{assert(condition, message)}"
    end
  end
end 
