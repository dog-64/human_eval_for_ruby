def double_the_difference(numbers)
  numbers.select { |n| n.is_a?(Integer) && n > 0 && n.odd? }
         .map { |n| n * n }
         .sum
end