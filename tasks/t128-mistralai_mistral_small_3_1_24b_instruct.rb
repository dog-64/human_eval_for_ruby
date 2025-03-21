def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.sum { |num| num.abs }
  sign_product = arr.map { |num| num.zero? ? 0 : num / num.abs }.reduce(:*)

  sum_abs * sign_product
end