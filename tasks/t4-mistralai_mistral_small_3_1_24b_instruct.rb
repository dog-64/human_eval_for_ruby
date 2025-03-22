def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?

  mean = numbers.sum / numbers.size
  deviations = numbers.map { |num| (num - mean).abs }
  deviations.sum / deviations.size
end