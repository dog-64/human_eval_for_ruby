def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array) && numbers.all? { |n| n.is_a?(Numeric) }
  return nil if numbers.empty?

  sorted_numbers = numbers.sort
  list_length = sorted_numbers.length

  if list_length.even?
    mid1 = sorted_numbers[list_length / 2 - 1]
    mid2 = sorted_numbers[list_length / 2]
    (mid1 + mid2).to_f / 2
  else
    sorted_numbers[list_length / 2].to_f
  end
end
