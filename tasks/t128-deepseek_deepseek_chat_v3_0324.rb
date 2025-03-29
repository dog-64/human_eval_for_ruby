def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.sum { |x| x.abs }
  product_signs = arr.inject(1) { |prod, x| prod * (x <=> 0) }
  sum_abs * product_signs
end