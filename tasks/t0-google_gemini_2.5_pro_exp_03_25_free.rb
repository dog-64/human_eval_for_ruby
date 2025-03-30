def has_close_elements(numbers, threshold)
  numbers.combination(2).any? do |num1, num2|
    (num1 - num2).abs <= threshold
  end
end
