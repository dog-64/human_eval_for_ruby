def has_close_elements(numbers, threshold)
  return false if numbers.length < 2

  numbers.each_with_index do |num1, index1|
    (index1 + 1...numbers.length).each do |index2|
      return true if (num1 - numbers[index2]).abs <= threshold
    end
  end

  false
end