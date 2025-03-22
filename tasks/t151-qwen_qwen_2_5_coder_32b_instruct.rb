def double_the_difference(numbers)
  numbers.select { |num| num.is_a?(Integer) && num > 0 && num.odd? }.map { |num| num**2 }.sum
end