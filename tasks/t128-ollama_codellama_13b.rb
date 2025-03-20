def prod_signs(arr)
  return nil if arr.empty?
  sum = arr.map(&:abs).sum
  sign = arr.map { |x| x < 0 ? -1 : (x == 0 ? 0 : 1) }.reduce(:*)
  sum * sign
end