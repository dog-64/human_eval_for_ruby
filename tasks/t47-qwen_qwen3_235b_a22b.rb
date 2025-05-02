def median(numbers)
  raise ArgumentError unless numbers.all? { |n| n.is_a?(Numeric) }
  return nil if numbers.empty?
  sorted = numbers.sort
  n = sorted.size
  mid = n / 2
  if n.even?
    (sorted[mid - 1] + sorted[mid]).fdiv(2)
  else
    sorted