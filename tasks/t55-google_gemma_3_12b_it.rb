def fib(n)
  return 1 if n == 1
  a, b = 0, 1
  (2..n).each do
    a, b = b, a + b
  end
  b
end
