
def fib4(n)
  return [0, 0, 2, 0][n] if n < 4
  
  a, b, c, d = 0, 0, 2, 0
  (4..n).each do
    a, b, c, d = b, c, d, a + b + c + d
  end
  d
end