def mean_absolute_deviation(numbers)
  if numbers.empty?
    return 0.0
  end

  sum = numbers.sum
  n = numbers.length
  mean = sum / n

  absolute_deviations = numbers.map { |number| (number - mean).abs }
  mad = absolute_deviations.sum / n

  mad
end
