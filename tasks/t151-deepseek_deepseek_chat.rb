def double_the_difference(numbers)
  numbers.select { |n| n > 0 && n == n.floor && n.odd? }.sum { |n| n**2 }
end