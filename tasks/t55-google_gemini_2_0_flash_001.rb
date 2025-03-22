def fib(n)
  a = 0
  b = 1
  n.times do
    a, b = b, a + b
  end
  b
end