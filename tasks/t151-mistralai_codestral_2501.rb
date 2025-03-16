def double_the_difference(numbers)
  numbers.select { |n| n.positive? && n == n.to_i && n.odd? }.sum { |n| n**2 }
end