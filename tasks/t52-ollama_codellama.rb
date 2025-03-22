def below_threshold(numbers, threshold)
  return true if numbers.empty?
  numbers.all? { |num| num < threshold }
end