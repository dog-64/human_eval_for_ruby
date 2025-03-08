def rescale_to_unit(numbers)
  raise ArgumentError, "Input list must contain at least two elements" if numbers.size < 2

  min_value = numbers.min
  max_value = numbers.max
  range_value = max_value - min_value

  numbers.map { |value| (value - min_value) / range_value }
end