def has_close_elements(numbers, threshold)
  return false if numbers.nil? || numbers.empty? || numbers.length == 1

  numbers.each_with_index do |num1, i|
    (i+1...numbers.length).each do |j|
      num2 = numbers[j]
      return true if (num1 - num2).abs <= threshold
    end
  end

  return false
end