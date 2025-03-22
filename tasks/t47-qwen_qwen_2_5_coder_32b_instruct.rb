def median(numbers)
  raise ArgumentError, "Array cannot be empty" if numbers.empty?
  raise ArgumentError, "Array must contain only numbers" unless numbers.all? { |num| num.is_a?(Numeric) }
  
  sorted_numbers = numbers.sort
  mid = sorted_numbers.length / 2

  if sorted_numbers.length.odd?
    sorted_numbers[mid]
  else
    (sorted_numbers[mid - 1] + sorted_numbers[mid]) / 2.0
  end
end