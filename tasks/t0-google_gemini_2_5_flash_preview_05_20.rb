def has_close_elements?(numbers, threshold)
  return false if numbers.length < 2

  numbers.combination(2).any? do |a, b|
    (a - b).abs <= threshold
  end
end