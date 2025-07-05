def prod_signs(arr)
  return nil if arr.empty?

  abs_sum = arr.map(&:abs).sum
  sign_product = arr.map { |num| num >= 0 ? 1 : -1 }.reduce(1, :*)

  abs_sum * sign_product
end
