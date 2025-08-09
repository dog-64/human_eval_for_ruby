def prod_signs(arr)
  return nil if arr.empty?
  sum_abs = arr.map(&:abs).sum
  sign_product = arr.reduce(1) do |prod, x|
    prod * (x > 0 ? 1 : (x < 0 ? -1 : 0))
  end
  sum_abs * sign_product
end