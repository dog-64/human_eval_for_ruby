def monotonic?(arr)
  return true if arr.empty? || arr.size == 1
  arr.each_cons(2).all? { |a, b| a <= b }
end