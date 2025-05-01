def fib(n)
  if n <= 2
    return n - 1
  end

  a = 0
  b = 1
  (n - 2).times do
    temp = a + b
    a = b
    b = temp
  end
  b
end