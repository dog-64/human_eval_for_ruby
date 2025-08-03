
def rescale_to_unit(numbers)
  if numbers.size < 2
    raise ArgumentError, "Input list must contain at least two elements"
  end

  min_val = numbers.min
  max_val = numbers.max

  if min_val == max_val
    raise ArgumentError, "Cannot scale: all numbers are equal"
  end

  range = max_val - min_val
  numbers.map { |x| (x - min_val) / range }
end