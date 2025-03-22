def fib4(n)
  return n if n < 2
  return 2 if n == 2
  return 0 if n == 3

  a, b, c, d = 0, 0, 2, 0
  (4..n).each do |i|
    e = a + b + c + d
    a, b, c, d = b, c, d, e
  end
  d
end