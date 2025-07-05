def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.length == 1

  mean = numbers.sum / numbers.length.to_f
  absolute_deviations = numbers.map { |num| (num - mean).abs }
  absolute_deviations.sum / absolute_deviations.length.to_f
end