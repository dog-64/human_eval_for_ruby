def median(numbers)
  raise ArgumentError, 'Input must be an array' unless numbers.is_a?(Array)
  return nil if numbers.empty?
  numbers.each do |n|
    raise ArgumentError, 'All elements must be numeric' unless n.is_a?(Integer) || n.is_a?(Float)
  end
  sorted = numbers.sort
  len = sorted.length
  mid = len / 2
  if len.odd?
    sorted[mid]
  else
    (sorted[mid - 1] + sorted[mid]) / 2.0
  end
end