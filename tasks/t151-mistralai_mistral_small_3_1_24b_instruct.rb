def double_the_difference(numbers)
  numbers.select { |num| num.is_a?(Integer) && num.positive? && num.odd? }.sum { |num| num ** 2 }
end