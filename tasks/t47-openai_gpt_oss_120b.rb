def median(numbers)
  return nil if numbers.empty?
  raise ArgumentError unless numbers.all? { |x| x.is_a?(Numeric) }
  sorted = numbers.sort
  n = sorted.length
  mid = n / 2
  n.odd? ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2.0
end