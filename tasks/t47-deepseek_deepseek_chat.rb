def median(numbers)
  return nil if numbers.empty?
  numbers.each { |num| raise ArgumentError, "All elements must be numeric" unless num.is_a?(Numeric) }

  sorted = numbers.sort
  len = sorted.length
  if len.odd?
    sorted[len / 2]
  else
    (sorted[len / 2 - 1] + sorted[len / 2]) / 2.0
  end
end