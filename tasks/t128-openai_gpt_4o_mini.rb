def prod_signs(arr)
  return nil if arr.empty?
  
  sum_abs = arr.map(&:abs).sum
  product_sign = arr.reduce(1) { |prod, num| prod * (num < 0 ? -1 : num > 0 ? 1 : 0) }
  
  sum_abs * product_sign
end