def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  mean = numbers.sum.to_f / numbers.size
  numbers.map { |num| (num - mean).abs }.sum / numbers.size
end