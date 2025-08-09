def rescale_to_unit(numbers)
  raise ArgumentError, "list must contain at least two elements" if numbers.size < 2
  min_val = numbers.min
  max_val = numbers.max
  range = max_val - min_val
  return numbers.map { 0.0 } if range == 0
  numbers.map { |x| (x - min_val) / range }
end