def double_the_difference(numbers)
  numbers.select { |n| n.positive? && n.to_i == n && n.odd? }.sum { |n| n * n }
end