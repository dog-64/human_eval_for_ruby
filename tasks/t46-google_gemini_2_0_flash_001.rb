def fib4(n)
  if n == 0
    0
  elsif n == 1
    0
  elsif n == 2
    2
  elsif n == 3
    0
  else
    a = 0
    b = 0
    c = 2
    d = 0
    for i in 4..n
      result = a + b + c + d
      a = b
      b = c
      c = d
      d = result
    end
    d
  end
end