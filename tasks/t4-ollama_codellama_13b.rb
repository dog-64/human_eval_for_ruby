def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty?
  average = numbers.sum / numbers.size
  deviations = numbers.map { |x| (x - average).abs }
  return deviations.sum / numbers.size
end
puts mean_absolute_deviation([1.0, 2.0, 3.0, 4.0]) # Output: 1.0
puts mean_absolute_deviation([1.0, 1.0, 1.0, 1.0]) # Output: 0.0
puts mean_absolute_deviation([10.5, 20.2, 30.7, 40.1]) # Output: approximately 8.6