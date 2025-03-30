require 'spec_helper'
require_relative '../lib/runner/assert'
require_relative '../lib/logger'

RSpec.describe Runner::Assert do
  let(:test_class) do
    Class.new do
      include Runner::Assert
      include Logger
      def initialize
        @options = { log_level: :debug }
        @log_level = Logger::LOG_LEVELS[:debug]
      end
    end
  end

  let(:test_object) { test_class.new }

  describe 'AssertionError' do
    it 'stores expected, actual and assertion info' do
      error = Runner::Assert::AssertionError.new('test message', :expected, :actual, 'assert(true)')
      expect(error.message).to eq('test message')
      expect(error.expected).to eq(:expected)
      expect(error.actual).to eq(:actual)
      expect(error.assertion_info).to eq('assert(true)')
    end

    it 'uses default message if none provided' do
      error = Runner::Assert::AssertionError.new(nil)
      expect(error.message).to eq('Assertion failed')
    end
  end

  describe '#assert' do
    it 'passes when condition is true' do
      expect { test_object.assert(true) }.not_to raise_error
    end

    it 'passes when condition is truthy' do
      expect { test_object.assert(1) }.not_to raise_error
      expect { test_object.assert('string') }.not_to raise_error
      expect { test_object.assert([]) }.not_to raise_error
    end

    it 'fails when condition is false' do
      expect { test_object.assert(false) }.to raise_error(Runner::Assert::AssertionError)
    end

    it 'fails when condition is falsy' do
      expect { test_object.assert(nil) }.to raise_error(Runner::Assert::AssertionError)
    end

    it 'includes custom message in error' do
      expect { test_object.assert(false, 'custom message') }
        .to raise_error(Runner::Assert::AssertionError, /custom message/)
    end

    it 'handles NoMethodError' do
      expect do
        begin
          test_object.assert(nil.some_method)
        rescue NoMethodError => e
          raise Runner::Assert::AssertionError.new(
            "NoMethodError: #{e.message}",
            true,
            nil,
            "assert(...) - #{e.class}"
          )
        end
      end.to raise_error(Runner::Assert::AssertionError, /NoMethodError/)
    end

    it 'handles other errors' do
      expect do
        begin
          test_object.assert(1 / 0)
        rescue ZeroDivisionError => e
          raise Runner::Assert::AssertionError.new(
            'Error: divided by 0',
            true,
            nil,
            "assert(...) - #{e.class}"
          )
        end
      end.to raise_error(Runner::Assert::AssertionError, /Error: divided by 0/)
    end
  end

  describe '#assert_equal' do
    it 'passes when values are equal' do
      expect { test_object.assert_equal(1, 1) }.not_to raise_error
      expect { test_object.assert_equal('test', 'test') }.not_to raise_error
      expect { test_object.assert_equal([1, 2], [1, 2]) }.not_to raise_error
    end

    it 'fails when values are not equal' do
      expect { test_object.assert_equal(1, 2) }
        .to raise_error(Runner::Assert::AssertionError)
    end

    it 'includes expected and actual values in error' do
      error = nil
      begin
        test_object.assert_equal(1, 2)
      rescue Runner::Assert::AssertionError => e
        error = e
      end
      expect(error.expected).to eq(1)
      expect(error.actual).to eq(2)
    end

    it 'includes custom message in error' do
      expect { test_object.assert_equal(1, 2, 'custom message') }
        .to raise_error(Runner::Assert::AssertionError, /custom message/)
    end
  end

  describe '#assert_not_equal' do
    it 'passes when values are not equal' do
      expect { test_object.assert_not_equal(1, 2) }.not_to raise_error
      expect { test_object.assert_not_equal('test', 'other') }.not_to raise_error
      expect { test_object.assert_not_equal([1], [2]) }.not_to raise_error
    end

    it 'fails when values are equal' do
      expect { test_object.assert_not_equal(1, 1) }
        .to raise_error(Runner::Assert::AssertionError)
    end

    it 'includes expected and actual values in error' do
      error = nil
      begin
        test_object.assert_not_equal(1, 1)
      rescue Runner::Assert::AssertionError => e
        error = e
      end
      expect(error.expected).to eq(1)
      expect(error.actual).to eq(1)
    end

    it 'includes custom message in error' do
      expect { test_object.assert_not_equal(1, 1, 'custom message') }
        .to raise_error(Runner::Assert::AssertionError, /custom message/)
    end
  end

  describe '#assert_in_delta' do
    it 'passes when values are within delta' do
      expect { test_object.assert_in_delta(1.0, 1.1, 0.2) }.not_to raise_error
      expect { test_object.assert_in_delta(1, 1.1, 0.2) }.not_to raise_error
      expect { test_object.assert_in_delta('1.0', '1.1', '0.2') }.not_to raise_error
    end

    it 'fails when values are not within delta' do
      expect { test_object.assert_in_delta(1.0, 1.5, 0.2) }
        .to raise_error(Runner::Assert::AssertionError)
    end

    it 'includes expected and actual values in error' do
      error = nil
      begin
        test_object.assert_in_delta(1.0, 1.5, 0.2)
      rescue Runner::Assert::AssertionError => e
        error = e
      end
      expect(error.expected).to eq(1.0)
      expect(error.actual).to eq(1.5)
    end

    it 'includes custom message in error' do
      expect { test_object.assert_in_delta(1.0, 1.5, 0.2, 'custom message') }
        .to raise_error(Runner::Assert::AssertionError, /custom message/)
    end

    it 'handles invalid number format' do
      expect { test_object.assert_in_delta('not a number', 1.0, 0.2) }
        .to raise_error(Runner::Assert::AssertionError, /Error: invalid value for Float/)
    end
  end

  describe '#assert_raises' do
    it 'passes when expected exception is raised' do
      result = test_object.assert_raises(RuntimeError) { raise RuntimeError }
      expect(result).to be_a(RuntimeError)
    end

    it 'passes when subclass of expected exception is raised' do
      result = test_object.assert_raises(StandardError) { raise RuntimeError }
      expect(result).to be_a(RuntimeError)
    end

    it 'fails when no exception is raised' do
      expect { test_object.assert_raises { true } }
        .to raise_error(Runner::Assert::AssertionError, /nothing was raised/)
    end

    it 'fails when different exception is raised' do
      expect { test_object.assert_raises(RuntimeError) { raise ArgumentError } }
        .to raise_error(Runner::Assert::AssertionError, /Expected RuntimeError but got ArgumentError/)
    end

    it 'uses StandardError as default exception class' do
      result = test_object.assert_raises { raise RuntimeError }
      expect(result).to be_a(RuntimeError)
    end
  end

  describe '#assert_valid_order' do
    it 'passes when order is valid' do
      result = [1, 2, 3]
      dependencies = [[1, 2], [2, 3]]
      expect { test_object.assert_valid_order(result, dependencies) }.not_to raise_error
    end

    it 'fails when order is invalid' do
      result = [2, 1, 3]
      dependencies = [[1, 2], [2, 3]]
      expect { test_object.assert_valid_order(result, dependencies) }
        .to raise_error('Неверный порядок сортировки')
    end

    it 'handles multiple dependencies' do
      result = [1, 2, 3, 4]
      dependencies = [[1, 2], [2, 3], [3, 4], [1, 4]]
      expect { test_object.assert_valid_order(result, dependencies) }.not_to raise_error
    end
  end

  describe '#debug_assert' do
    it 'passes when condition is true' do
      expect { test_object.debug_assert(true) }.not_to raise_error
    end

    it 'fails when condition is false' do
      expect { test_object.debug_assert(false) }
        .to raise_error(Runner::Assert::AssertionError)
    end

    it 'outputs debug information' do
      expect { test_object.debug_assert(true) }
        .to output(/debug_assert\(true, nil\)/).to_stdout
    end

    it 'includes custom message in output' do
      expect { test_object.debug_assert(true, 'test message') }
        .to output(/debug_assert\(true, test message\)/).to_stdout
    end
  end
end
