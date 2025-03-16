def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  average = numbers.sum / numbers.size
  deviations = numbers.map { |x| (x - average).abs }
  return deviations.sum / numbers.size
end
