def prod_signs(arr)
  return nil if arr.empty?

  sum_of_abs = arr.sum(&:abs)
  product_of_signs = arr.reduce(1) { |product, num| product * (num <=> 0) }

  sum_of_abs * product_of_signs
end