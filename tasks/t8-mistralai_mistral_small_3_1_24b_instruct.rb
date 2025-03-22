def sum_product(numbers)
  sum = numbers.reduce(0, :+)
  product = numbers.reduce(1, :*)
  [sum, product]
end