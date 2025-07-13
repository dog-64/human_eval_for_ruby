def fib4(n)
  return 0 if n == 0 || n == 1 || n == 3
  return 2 if n == 2
  
  a, b, c, d = 0, 0, 2, 0
  
  4.upto(n) do
    e = a + b + c + d
    a, b, c, d = b, c, d, e
  end
  
  d
end