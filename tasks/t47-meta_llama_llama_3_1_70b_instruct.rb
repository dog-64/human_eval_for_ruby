def median(numbers)
  raise ArgumentError, 'Input list cannot be empty' if numbers.empty?
  raise ArgumentError, 'Input list must contain only numbers' unless numbers.all? { |n| n.is_a?(Numeric) }
  sorted_numbers = numbers.sort
  middle_index = sorted_numbers.size / 2
  if sorted_numbers.size.odd?
    sorted_numbers[middle_index]
  else
    (sorted_numbers[middle_index - 1] + sorted_numbers[middle_index]).to_f / 2
  end
end