def prod_signs(arr)
  return nil if arr.empty?
  sum = arr.sum
  sign_product = arr.all? { |num| num == 0 } ? 0 : arr.map { |num| num.positive? ? 1 : -1 }.reduce(:*)
  -(sum * sign_product)
end