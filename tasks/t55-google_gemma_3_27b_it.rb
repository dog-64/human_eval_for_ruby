def fib(n)
  if n <= 2
    return 1
  else
    a = 1
    b = 1
    for i in 3..n
      temp = a + b
      a = b
      b = temp
    end
    return b
  end
end