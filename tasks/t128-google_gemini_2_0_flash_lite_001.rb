def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.sum(&:abs)
  prod_signs = arr.map { |x| x <=> 0 }.reduce(:*)

  sum_abs * prod_signs
end