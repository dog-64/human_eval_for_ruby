def median(numbers)
  return nil if numbers.empty?

  sorted = numbers.sort
  n = sorted.size
  return (sorted[n / 2] + sorted[(n + 1) / 2]) / 2.0 if n.odd?
  return sorted[n / 2] if n.even?
end