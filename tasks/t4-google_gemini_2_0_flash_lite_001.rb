def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.length == 1

  mean = numbers.sum.to_f / numbers.length
  sum_of_abs_deviations = numbers.sum { |number| (number - mean).abs }
  sum_of_abs_deviations / numbers.length
end