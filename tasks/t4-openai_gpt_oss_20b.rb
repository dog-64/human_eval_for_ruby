def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.size == 1
  mean = numbers.sum.to_f / numbers.size
  deviations = numbers.map { |x| (x - mean).abs }
  deviations.sum.to_f / deviations.size
end