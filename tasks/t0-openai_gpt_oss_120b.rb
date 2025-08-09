def has_close_elements(numbers, threshold)
  return false if numbers.length < 2
  sorted = numbers.sort
  (0...sorted.length - 1).each do |i|
    return true if (sorted[i + 1] - sorted[i]).abs <= threshold
  end
  false
end