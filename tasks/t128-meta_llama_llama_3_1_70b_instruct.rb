def prod_signs(arr)
  return nil if arr.empty?

  signs = arr.map { |x| x <=> 0 }
  signs_product = signs.inject(:*)
  sum_abs = arr.map(&:abs).sum

  sum_abs * signs_product
end