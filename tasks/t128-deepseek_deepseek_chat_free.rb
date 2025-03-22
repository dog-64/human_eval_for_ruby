def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.sum(&:abs)
  prod_sign = arr.reduce(1) { |acc, num| acc * (num <=> 0) }
  sum_abs * prod_sign
end