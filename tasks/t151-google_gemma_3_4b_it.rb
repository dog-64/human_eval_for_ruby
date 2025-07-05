def double_the_difference(numbers)
  sum = 0
  numbers.each do |number|
    if number.is_a?(Integer) && number % 2 != 0
      sum += number * number
    end
  end
  sum
end
