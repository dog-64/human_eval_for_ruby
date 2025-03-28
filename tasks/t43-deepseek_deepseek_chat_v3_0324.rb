def pairs_sum_to_zero(numbers)
  numbers.each_with_index do |num1, i|
    numbers.each_with_index do |num2, j|
      return true if i != j && num1 + num2 == 0
    end
  end
  false
end