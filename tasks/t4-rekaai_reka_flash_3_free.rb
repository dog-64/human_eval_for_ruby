
def mean_absolute_deviation(numbers)
  return 0.0 if numbers.empty? || numbers.size == 1

  mean = numbers.sum / numbers.size
  sum_abs = numbers.sum { |x| (x - mean).abs }
  sum_abs / numbers.size
end

 