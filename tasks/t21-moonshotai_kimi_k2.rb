def rescale_to_unit(numbers)
  raise ArgumentError, "List must contain at least two elements" if numbers.size < 2
  
  min = numbers.min
  max = numbers.max
  range = max - min
  
  return numbers.map { |num| (num - min) / range }
end