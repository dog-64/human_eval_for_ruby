def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?

  mean = numbers.sum / numbers.size.to_f
  mad = numbers.map { |num| (num - mean).abs }.sum / numbers.size.to_f

  mad
end