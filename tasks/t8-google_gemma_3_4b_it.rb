def sum_product(numbers)
  sum_nums = 0
  product_nums = 1

  numbers.each do |num|
    sum_nums += num
    product_nums *= num
  end

  [sum_nums, product_nums]
end
