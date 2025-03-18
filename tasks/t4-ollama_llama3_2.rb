def mean_absolute_deviation(numbers)
  return 0 if numbers.empty?
  sum = 0
  count = 0
  mean = numbers.reduce(:+) / numbers.size
  numbers.each do |n|
    sum += (n - mean).abs
    count += 1
  end
  sum / count
end