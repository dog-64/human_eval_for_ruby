def fib4(n)
  return 0 if n == 0 || n == 1
  return 2 if n == 2
  return 0 if n == 3

  a, b = 0, 2
  (n - 4).times do
    a, b = b, a + b
  end
  a
end