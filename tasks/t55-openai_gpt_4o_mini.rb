def fib(n)
  return 0 if n == 1
  return 1 if n == 2
  a, b = 0, 1
  (3..n).each do
    a, b = b, a + b
  end
  b
end