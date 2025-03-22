def fibfib(n)
  if n == 0
    return 0
  elsif n == 1
    return 0
  elsif n == 2
    return 1
  else
    a = 0
    b = 0
    c = 1
    for i in 3..n
      temp = a + b + c
      a = b
      b = c
      c = temp
    end
    return c
  end
end