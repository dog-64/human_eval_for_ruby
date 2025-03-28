def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?

  mean = numbers.reduce(:+) / numbers.length
  deviation_sum = numbers.map { |num| (num - mean).abs }.reduce(:+)
  deviation_sum / numbers.length
end