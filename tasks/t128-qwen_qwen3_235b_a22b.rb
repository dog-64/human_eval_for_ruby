def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.sum(&:abs)
  product_sign = arr.map { |num| num <=> 0 }.reduce(1, :*)
  sum_abs * product_sign
end