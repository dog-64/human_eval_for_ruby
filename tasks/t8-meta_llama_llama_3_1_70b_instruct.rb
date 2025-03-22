def sum_product(numbers)
  sum = numbers.sum || 0
  product = numbers.reduce(1, :*) || 1
  [sum, product]
end