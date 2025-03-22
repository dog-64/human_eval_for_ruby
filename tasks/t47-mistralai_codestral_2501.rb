def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array) && numbers.all? { |n| n.is_a?(Numeric) }
  return nil if numbers.empty?

  sorted_numbers = numbers.sort
  mid = sorted_numbers.size / 2

  if sorted_numbers.size.odd?
    sorted_numbers[mid]
  else
    (sorted_numbers[mid - 1] + sorted_numbers[mid]) / 2.0
  end
end