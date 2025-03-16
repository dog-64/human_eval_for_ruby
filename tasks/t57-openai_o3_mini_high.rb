def monotonic?(arr)
  arr.each_cons(2).all? { |a, b| a <= b } || arr.each_cons(2).all? { |a, b| a >= b }
end