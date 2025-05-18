def has_close_elements(numbers, threshold)
  return false if numbers.length < 2
  (0...numbers.length).any? { |i| (i+1...numbers.length).any? { |j| (numbers[i] - numbers[j]).abs <= threshold } }
end