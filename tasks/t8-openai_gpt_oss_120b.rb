def sum_product(numbers)
  sum = numbers.sum
  product = numbers.empty? ? 1 : numbers.reduce(1) { |acc, n| acc * n }
  [sum, product]
end