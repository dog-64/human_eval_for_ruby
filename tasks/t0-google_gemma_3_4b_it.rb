def has_close_elements?(numbers, threshold)
  return false if numbers.empty?
  return false if numbers.length <= 1

  numbers.each_with_index do |num1, i|
    numbers.each_with_index do |num2, j|
      if i != j && (num2 - num1).abs <= threshold
        return true
      end
    end
  end

  false
end
