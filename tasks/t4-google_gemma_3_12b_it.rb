def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  return 0.0 if numbers.length == 1

  mean = numbers.sum / numbers.length
  absolute_deviations = numbers.map { |x| (x - mean).abs }
  absolute_deviations.sum / numbers.length
end
