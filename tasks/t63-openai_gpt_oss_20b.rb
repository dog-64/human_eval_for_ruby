def fibfib(n)
  return 0 if n == 0 || n == 1
  return 1 if n == 2
  a = 0
  b = 0
  c = 1
  (3..n).each do
    a, b, c = b, c, a + b + c
  end
  c
end