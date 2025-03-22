def has_close_elements(numbers, threshold)
  return false if numbers.length < 2

  numbers.each_with_index do |num1, i|
    numbers[i+1..-1].each do |num2|
      return true if (num1 - num2).abs <= threshold
    end
  end
  false
end