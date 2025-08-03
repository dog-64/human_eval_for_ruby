
def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  
  mean = numbers.sum / numbers.size.to_f
  absolute_deviations = numbers.map { |num| (num - mean).abs }
  absolute_deviations.sum / absolute_deviations.size.to_f
end