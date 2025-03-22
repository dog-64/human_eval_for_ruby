def median(numbers)
  raise ArgumentError, "Input list cannot be empty" if numbers.empty?
  raise ArgumentError, "Input list must contain only numbers" unless numbers.all? { |num| num.is_a?(Numeric) }

  sorted_numbers = numbers.sort
  len = sorted_numbers.length
  mid = len / 2

  if len.odd?
    sorted_numbers[mid]
  else
    (sorted_numbers[mid - 1] + sorted_numbers[mid]) / 2.0
  end
end