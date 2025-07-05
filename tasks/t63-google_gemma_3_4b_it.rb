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
    (3..n).each do
      next_fib = a + b + c
      a = b
      b = c
      c = next_fib
    end
    c
  end
end
