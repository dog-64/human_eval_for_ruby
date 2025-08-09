def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.size == 1
  mean = numbers.sum.to_f / numbers.size
  total = numbers.reduce(0.0) { |sum, x| sum + (x - mean).abs }
  total / numbers.size
end