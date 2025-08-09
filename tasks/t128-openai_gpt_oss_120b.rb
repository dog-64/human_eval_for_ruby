def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.reduce(0) { |s, x| s + x.abs }
  prod_sign = arr.reduce(1) { |p, x| p * (x <=> 0) }
  sum_abs * prod_sign
end