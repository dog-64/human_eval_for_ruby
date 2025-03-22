def fibfib(n)
  return 0 if n < 2
  return 1 if n == 2

  a, b, c = 0, 0, 1
  (3..n).each do
    a, b, c = b, c, a + b + c
  end
  c
end