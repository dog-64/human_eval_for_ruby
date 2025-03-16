def double_the_difference(numbers)
  numbers.select { |n| n.is_a?(Integer) && n.positive? && n.odd? }
         .sum { |n| n * n }
end