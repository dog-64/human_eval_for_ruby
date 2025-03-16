def fib4(n)
  base = [0, 0, 2, 0]
  return base[n] if n < 4
  a, b, c, d = base
  (4..n).each do |_|
    e = a + b + c + d
    a, b, c, d = b, c, d, e
  end
  d
end