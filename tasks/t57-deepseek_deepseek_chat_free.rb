def monotonic?(arr)
  return true if arr.length <= 1
  increasing = arr.each_cons(2).all? { |a, b| a <= b }
  decreasing = arr.each_cons(2).all? { |a, b| a >= b }
  increasing || decreasing
end