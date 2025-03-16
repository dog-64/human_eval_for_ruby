def sum_product(numbers)
  [numbers.sum, numbers.inject(1) { |p, n| p * n } ]
end