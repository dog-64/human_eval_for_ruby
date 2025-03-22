def fib(n)
  return n if n <= 2
  a, b = 0, 1
  (3..n).each do
    a, b = b, a + b
  end
  b
end