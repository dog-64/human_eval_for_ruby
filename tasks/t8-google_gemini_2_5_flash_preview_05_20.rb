def sum_product(numbers)
  sum = numbers.sum
  product = numbers.empty? ? 1 : numbers.reduce(1, :*)
  [sum, product]
end