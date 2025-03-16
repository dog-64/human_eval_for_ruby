def prod_signs(arr)
  return nil if arr.empty?
  sum = arr.map(&:abs).sum
  prod = arr.reduce(1) do |acc, x|
    acc * (x > 0 ? 1 : x < 0 ? -1 : 0)
  end
  sum * prod
end