def has_close_elements(numbers, threshold)
  return false if numbers.size < 2
  numbers.each_with_index do |num, i|
    (i + 1...numbers.size).each do |j|
      return true if (num - numbers[j]).abs <= threshold
    end
  end
  false
end