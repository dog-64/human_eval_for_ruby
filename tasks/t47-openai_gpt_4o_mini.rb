def median(numbers)
  raise ArgumentError, 'Input must be an array' unless numbers.is_a?(Array)
  raise ArgumentError, 'Array cannot be empty' if numbers.empty?
  numbers.each { |n| raise ArgumentError, 'All elements must be numeric' unless n.is_a?(Numeric) }
  
  sorted = numbers.sort
  len = sorted.length
  
  if len.odd?
    sorted[len / 2]
  else
    (sorted[(len / 2) - 1] + sorted[len / 2]) / 2.0
  end
end