def prod_signs(arr)
  return nil if arr.empty?
  sum = arr.map(&:abs).sum
  prod = arr.map { |x| x < 0 ? -1 : 1 }.reduce(:*)
  sum * prod
end
