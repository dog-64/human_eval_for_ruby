def fib(n)
  return 1 if n <= 2
  a = 1
  b = 1
  (3..n).each do
    a, b = b, a + b
  end
  b
end