def rescale_to_unit(numbers)
  raise ArgumentError, "List must contain at least two elements" if numbers.size < 2

  min_val = numbers.min
  max_val = numbers.max

  if min_val == max_val
    return Array.new(numbers.size, 0.5)
  end

  numbers.map { |num| (num - min_val) / (max_val - min_val) }
end