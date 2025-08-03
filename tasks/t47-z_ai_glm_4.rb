
def median(numbers)
  raise ArgumentError, "List cannot be empty" if numbers.empty?
  numbers.each { |num| raise ArgumentError, "All elements must be numbers" unless num.is_a?(Numeric) }
  
  sorted = numbers.sort
  n = sorted.length
  
  if n.odd?
    sorted[n / 2]
  else
    (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
  end
end