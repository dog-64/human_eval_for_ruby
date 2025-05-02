def rescale_to_unit(numbers)
  if numbers.size < 2
    raise ArgumentError, "Input list must contain at least two elements"
  end
  min = numbers.min
  max = numbers.max
  if min == max
    Array.new(numbers.size, 0.0)
  else
    range = max - min
    numbers.map { |x| (x - min) / range }
  end
end