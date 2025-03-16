def median(numbers)
  raise ArgumentError, "All elements must be Numeric" unless numbers.all? { |num| num.is_a?(Numeric) }
  return nil if numbers.empty?
  sorted = numbers.sort
  n = sorted.size
  if n.odd?
    sorted[n / 2]
  else
    (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
  end
end