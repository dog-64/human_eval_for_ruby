def median(numbers)
  raise ArgumentError, "Input must be an array" unless numbers.is_a?(Array)
  raise ArgumentError, "Array cannot be empty" if numbers.empty?
  raise ArgumentError, "All elements must be numeric" unless numbers.all? { |n| n.is_a?(Numeric) }
  
  sorted = numbers.sort
  length = sorted.length
  
  if length.odd?
    sorted[length / 2].to_f
  else
    (sorted[length / 2 - 1] + sorted[length / 2]) / 2.0
  end
end