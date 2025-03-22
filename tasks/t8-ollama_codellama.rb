def sum_product(numbers)
  sum = numbers.sum
  product = numbers.reduce(:*)
  [sum, product]
end