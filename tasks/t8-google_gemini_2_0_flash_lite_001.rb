def sum_product(numbers)
  sum = numbers.sum
  product = numbers.empty? ? 1 : numbers.inject(:*)
  [sum, product]
end