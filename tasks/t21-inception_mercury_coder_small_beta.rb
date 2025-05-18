def rescale_to_unit(numbers)
  raise ArgumentError, "List must contain at least two elements" if numbers.size < 2

  min_value = numbers.min
  max_value = numbers.max
  range = max_value - min_value

  numbers.map { |num| (num - min_value) / range }
end