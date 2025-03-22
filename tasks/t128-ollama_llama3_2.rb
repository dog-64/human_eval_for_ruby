def prod_signs(arr)
  return nil if arr.empty?
  signs = arr.map { |x| x == 0 ? 0 : (x < 0 ? -1 : 1) }
  sum_abs = arr.sum(&:abs)
  product_signs = signs.reduce(1, :*)
  sum_abs * product_signs
end