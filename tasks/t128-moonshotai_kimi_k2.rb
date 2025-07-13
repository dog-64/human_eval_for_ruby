def prod_signs(arr)
  return nil if arr.empty?
  
  sum_abs = arr.map(&:abs).sum
  sign_product = arr.map { |n| n <=> 0 }.reduce(1, :*)
  
  sum_abs * sign_product
end