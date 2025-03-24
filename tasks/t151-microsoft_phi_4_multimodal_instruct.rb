def double_the_difference(numbers)
  numbers.select { |num| num.is_a?(Integer) && num.positive? && num.odd? }.map { |num| num**2 }.sum * 2
end