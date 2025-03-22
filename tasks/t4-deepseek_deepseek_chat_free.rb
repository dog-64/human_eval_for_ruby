def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  mean = numbers.sum / numbers.size
  numbers.map { |x| (x - mean).abs }.sum / numbers.size
end