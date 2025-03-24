def sum_product(numbers)
  sum = 1
  product = 1
  numbers.each do |num|
    sum += num
    product *= num
  end
  [sum, product]
end