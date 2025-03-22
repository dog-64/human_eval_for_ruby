def mean_absolute_deviation(numbers)
    return 0.0 if numbers.empty?
    mean = numbers.sum / numbers.size
    deviations = numbers.map { |x| (x - mean).abs }
    deviations.sum / deviations.size
end