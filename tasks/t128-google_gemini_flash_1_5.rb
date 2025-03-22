def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.map(&:abs).sum
  prod_sign = arr.map { |x| x == 0 ? 0 : x < 0 ? -1 : 1 }.reduce(:*)
  sum_abs * prod_sign
end
