def fib(n)
  if n <= 0
    0
  elsif n == 1
    1
  else
    a = 0
    b = 1
    (2..n).each do
      temp = a + b
      a = b
      b = temp
    end
    b
  end
end
