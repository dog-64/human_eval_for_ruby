def has_close_elements(numbers, threshold)
  numbers.each_with_index do |num1, i|
    numbers.each_with_index do |num2, j|
      next if i == j
      return true if (num1 - num2).abs <= threshold
    end
  end
  false
end