def sum_product(numbers)
  sum = numbers.sum
  product = numbers.reduce(1, :*)
  product = 1 if numbers.empty?
  [sum, product]
end