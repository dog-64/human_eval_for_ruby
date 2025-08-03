
def sum_product(numbers)
  sum = numbers.inject(0, :+)
  product = numbers.inject(1, :*)
  [sum, product]
end