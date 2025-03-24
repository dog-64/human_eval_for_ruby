def has_close_elements(numbers, threshold)
  numbers.combination(2).any? { |a, b| (a - b).abs <= threshold }
end
