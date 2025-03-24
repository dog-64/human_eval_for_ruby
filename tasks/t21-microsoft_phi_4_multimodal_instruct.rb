def rescale_to_unit(numbers)
  raise ArgumentError, 'List must contain at least two elements' unless numbers.size >= 2

  min, max = numbers.minmax
  numbers.map { |number| (number - min) / (max - min) }
end