def mean_absolute_deviation(numbers)
  return 0.0 if numbers.size < 2

  mean = numbers.sum / numbers.size.to_f
  deviations = numbers.map { |num| (num - mean).abs }
  sum_of_deviations = deviations.sum
  sum_of_deviations / numbers.size.to_f
end