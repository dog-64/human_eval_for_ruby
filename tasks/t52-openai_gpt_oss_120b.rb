def below_threshold(numbers, threshold)
  numbers.all? { |n| n < threshold }
end