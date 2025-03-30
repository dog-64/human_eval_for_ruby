
def fib4(n)
  return 0 if n == 0 || n == 1
  return 2 if n == 2
  return 0 if n == 3

  a, b, c, d = 0, 0, 2, 0

  (4..n).each do
    next_val = a + b + c + d
    a, b, c, d = b, c, d, next_val
  end

  d
end

 