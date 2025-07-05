def median(numbers)
  raise ArgumentError, 'Input must be an array of numbers' if numbers.nil? || !numbers.is_a?(Array)

  numbers.each do |num|
    raise ArgumentError, 'Input array must contain only numbers' unless num.is_a?(Numeric)
  end

  return nil if numbers.empty?

  sorted_numbers = numbers.sort

  array_length = sorted_numbers.length

  if array_length.odd?
    sorted_numbers[array_length / 2.0]
  else
    (sorted_numbers[array_length / 2.0 - 1] + sorted_numbers[array_length / 2.0]) / 2.0
  end
end
