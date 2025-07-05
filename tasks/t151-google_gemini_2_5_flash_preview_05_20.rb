def double_the_difference(numbers)
  sum_of_squares = 0
  numbers.each do |num|
    if num.is_a?(Integer) && num > 0 && num.odd?
      sum_of_squares += num * num
    end
  end
  sum_of_squares
end