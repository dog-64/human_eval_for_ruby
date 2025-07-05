def fib(n)
  a, b = 0, 1
  (n - 1).times do
    a, b = b, a + b
  end
  b
end