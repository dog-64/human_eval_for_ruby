def rescale_to_unit(numbers)
  raise ArgumentError, 'List must contain at least two elements' if numbers.size < 2

  min_val = numbers.min
  max_val = numbers.max
  range = max_val - min_val

  return Array.new(numbers.size, 0.0) if range.zero?

  numbers.map { |num| (num - min_val) / range }
end