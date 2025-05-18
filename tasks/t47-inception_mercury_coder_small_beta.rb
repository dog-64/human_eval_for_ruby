def median(numbers)
  raise ArgumentError, "List cannot be empty" if numbers.empty?
  raise ArgumentError, "List contains non-numeric values" unless numbers.all? { |n| n.is_a?(Numeric) }
  sorted_numbers = numbers.sort
  mid_index = sorted_numbers.length / 2
  if sorted_numbers.length.odd?
    sorted_numbers[mid_index]
  else
    (sorted_numbers[mid_index - 1] + sorted_numbers[mid_index]) / 2.0
  end
end