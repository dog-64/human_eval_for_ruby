class AssertionError < StandardError
  attr_reader :expected, :actual, :line_info
  
  def initialize(message = "Assertion failed", expected = nil, actual = nil, line_info = nil)
    super(message)
    @expected = expected
    @actual = actual
    @line_info = line_info
  end
end

def assert(condition, message = nil)
  expected = true  # assert всегда ожидает true
  actual = !!condition  # приводим условие к boolean
  message ||= "Expected #{expected.inspect} but got #{actual.inspect}"
  
  unless condition
    # Получаем информацию о вызове из стека
    caller_line = caller.find { |line| !line.include?('lib/assert.rb') }
    raise AssertionError.new(message, expected, actual, caller_line)
  end
end

def assert_equal(expected, actual, message = nil)
  message ||= "Expected #{expected.inspect} but got #{actual.inspect}"
  assert(expected == actual, message)
end

def assert_valid_order(result, dependencies)
  dependencies.each do |pred, succ|
    pred_index = result.index(pred)
    succ_index = result.index(succ)
    raise "Неверный порядок сортировки" unless pred_index < succ_index
  end
end

def assert_raises(exception_class)
  begin
    yield
    raise "Ожидалось исключение #{exception_class}, но оно не было вызвано"
  rescue exception_class
    true
  rescue StandardError => e
    raise "Ожидалось исключение #{exception_class}, но было получено #{e.class}: #{e.message}"
  end
end

def debug_assert(condition, message = nil)
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | debug_assert(#{condition}, #{message})"
  assert_result = condition
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | assert_result =#{assert_result.inspect}"
  
  assert(condition, message)
end

def assert_in_delta(actual, expected, delta, message = nil)
  message ||= "Expected #{actual.inspect} to be within #{delta} of #{expected.inspect}"
  out = assert((actual - expected).abs <= delta, message)
  unless out
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | assert_in_delta('#{actual}', '#{expected}', '#{delta}', '#{message}')"
  end
  out
end 
