def fib(n)
  return 0 if n == 0
  return 1 if n == 1

  a, b = 0, 1
  (n - 1).times do
    a, b = b, a + b
  end
  b
end