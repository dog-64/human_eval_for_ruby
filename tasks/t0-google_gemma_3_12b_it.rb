def has_close_elements(numbers, threshold)
  return false if numbers.empty? || numbers.length == 1
  numbers.each_with_index do |num1, index1|
    numbers.each_with_index do |num2, index2|
      next if index1 == index2
      return true if (num1 - num2).abs <= threshold
    end
  end
  false
end
