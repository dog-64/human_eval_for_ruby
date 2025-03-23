def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array)
  raise ArgumentError, "Array elements must be numbers" unless numbers.all? { |x| x.is_a?(Numeric) }

  return nil if numbers.empty?

  sorted_numbers = numbers.sort
  length = sorted_numbers.length

  if length.odd?
    return sorted_numbers[length / 2].to_f
  else
    middle1 = sorted_numbers[length / 2 - 1]
    middle2 = sorted_numbers[length / 2]
    return (middle1 + middle2).to_f / 2
  end
end