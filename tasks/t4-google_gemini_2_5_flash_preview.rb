def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?

  mean = numbers.sum / numbers.length.to_f
  absolute_deviations = numbers.map { |number| (number - mean).abs }
  absolute_deviations.sum / absolute_deviations.length.to_f
end