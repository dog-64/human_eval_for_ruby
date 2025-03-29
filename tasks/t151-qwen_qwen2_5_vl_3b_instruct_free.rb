def double_the_difference(numbers)
  numbers.select { |num| num.positive? && num.odd? }.map { |num| num ** 2 }.sum
end