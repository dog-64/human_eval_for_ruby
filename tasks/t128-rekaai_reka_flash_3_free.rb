
def prod_signs(arr)
  return nil if arr.empty?
  return 0 if arr.any? { |n| n == 0 }
  sum = arr.sum { |x| x.abs }
  product = arr.reduce(1) { |p, x| p * (x > 0 ? 1 : -1) }
  sum * product
end

 