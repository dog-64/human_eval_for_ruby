def below_threshold(numbers, threshold)
  numbers.empty? || numbers.all? { |n| n <= threshold }
end