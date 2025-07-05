def sum_product(numbers)
  sum_numbers = numbers.sum(0)
  product_numbers = numbers.reduce(1, :*)
  [sum_numbers, product_numbers]
end
