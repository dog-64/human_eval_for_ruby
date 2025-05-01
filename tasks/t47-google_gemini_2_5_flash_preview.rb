def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array)
  raise ArgumentError, "Input array cannot be empty" if numbers.empty?
  raise ArgumentError, "Input array must contain only numbers" unless numbers.all? { |n| n.is_a?(Numeric) }

  sorted_numbers = numbers.sort
  n = sorted_numbers.length
  mid_index = n / 2

  if n.odd?
    sorted_numbers[mid_index]
  else
    (sorted_numbers[mid_index - 1] + sorted_numbers[mid_index]) / 2.0
  end
end
