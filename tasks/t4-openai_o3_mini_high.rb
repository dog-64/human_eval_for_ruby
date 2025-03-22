def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  mean = numbers.sum.to_f / numbers.size
  numbers.reduce(0.0) { |sum, n| sum + (n - mean).abs } / numbers.size
end