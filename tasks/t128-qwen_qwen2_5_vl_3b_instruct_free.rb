def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.sum { |x| x.abs }
  sign_product = arr.reduce(1) { |product, x| product * x.sign }

  sum_abs * sign_product
end
