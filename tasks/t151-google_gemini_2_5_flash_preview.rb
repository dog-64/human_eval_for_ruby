def double_the_difference(numbers)
  sum = 0
  numbers.each do |num|
    if num.is_a?(Integer) && num > 0 && num.odd?
      sum += num * num
    end
  end
  sum
end