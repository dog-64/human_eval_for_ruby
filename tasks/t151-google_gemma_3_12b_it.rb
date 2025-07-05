def double_the_difference(numbers)
  sum_of_squares = 0
  numbers.each do |number|
    if number.is_a?(Integer) && number > 0 && number.odd?
      sum_of_squares += number * number
    end
  end
  sum_of_squares
end
