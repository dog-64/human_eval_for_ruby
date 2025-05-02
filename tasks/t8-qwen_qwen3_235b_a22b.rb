def sum_product(numbers)
  [numbers.inject(0, :+), numbers.inject(1, :*)]
end