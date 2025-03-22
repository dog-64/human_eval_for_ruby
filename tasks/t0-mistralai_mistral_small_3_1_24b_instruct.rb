def has_close_elements(numbers, threshold)
  return false if numbers.size < 2

  numbers.sort!
  (0...numbers.size - 1).each do |i|
    return true if (numbers[i + 1] - numbers[i]).abs <= threshold
  end

  false
end