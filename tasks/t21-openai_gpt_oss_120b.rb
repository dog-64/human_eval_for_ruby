def rescale_to_unit(numbers)
  raise ArgumentError, "At least two elements required" if numbers.size < 2
  min_val = numbers.min
  max_val = numbers.max
  range = max_val - min_val
  if range.zero?
    numbers.map { 0.0 }
  else
    numbers.map { |n| (n - min_val) / range }
  end
end