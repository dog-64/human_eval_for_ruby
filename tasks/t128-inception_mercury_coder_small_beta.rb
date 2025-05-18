def prod_signs(arr)
  return nil if arr.empty?

  sum_of_abs = arr.map(&:abs).sum
  product_of_signs = arr.map { |num| num > 0 ? 1 : num < 0 ? -1 : 0 }.reduce(:*)

  sum_of_abs * product_of_signs
end