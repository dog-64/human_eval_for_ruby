def fib(n)
  return n if n <= 2
  a, b = 1, 1
  (n - 2).times { a, b = b, a + b }
  b
end