
def double_the_difference(numbers)
  numbers.select { |n| n > 0 && n == n.to_i && n.odd? }.map { |n| n ** 2 }.sum
end

 