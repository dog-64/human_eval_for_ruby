def double_the_difference(numbers)
  numbers.select { |num| num > 0 && num.integer? && num.odd? }
         .map { |num| num ** 2 }
         .sum
end