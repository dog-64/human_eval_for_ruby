def sum_product(numbers)
  sum = numbers.sum
  product = numbers.reduce(1, :*)
  [sum, product]
end