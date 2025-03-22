def prod_signs(arr)
  return nil if arr.empty?
  
  sum_abs = arr.sum { |x| x.abs }
  prod_sign = arr.reduce(1) { |acc, x| acc * (x <=> 0) }
  
  sum_abs * prod_sign
end