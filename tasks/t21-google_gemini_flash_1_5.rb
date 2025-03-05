def rescale_to_unit(numbers)
  raise ArgumentError, "Input list must contain at least two elements" if numbers.length < 2
  min_val = numbers.min
  max_val = numbers.max
  numbers.map { |num| (num - min_val) / (max_val - min_val) }
end
