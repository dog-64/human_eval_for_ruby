def has_close_elements(numbers, threshold)
  return false if numbers.size < 2

  sorted = numbers.sort
  (0...sorted.size - 1).each do |i|
    return true if sorted[i+1] - sorted[i] <= threshold
  end
  false
end