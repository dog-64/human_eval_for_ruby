def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.length == 1

  sum = numbers.sum
  mean = sum.to_f / numbers.length

  absolute_deviations_sum = numbers.map { |x| (x - mean).abs }.sum
  absolute_deviations_sum / numbers.length
end