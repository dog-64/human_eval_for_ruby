def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.sum(&:abs)
  prod_sign = arr.map { |num| num <=> 0 }.reduce(:*)

  sum_abs * prod_sign
end