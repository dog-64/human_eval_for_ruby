
def rescale_to_unit(numbers)
  raise ArgumentError, "List must contain at least two elements" if numbers.length < 2

  min_val = numbers.min
  max_val = numbers.max

  if min_val == max_val
    return numbers.map { |x| 0.0 }
  end

  numbers.map { |x| (x - min_val).fdiv(max_val - min_val) }
end
