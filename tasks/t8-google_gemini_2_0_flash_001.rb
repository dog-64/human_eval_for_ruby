def sum_product(numbers)
  sum = 0
  product = 1
  numbers.each do |number|
    sum += number
    product *= number
  end
  return [sum, product]
end