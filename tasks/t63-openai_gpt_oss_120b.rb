def fibfib(n)
  return 0 if n == 0 || n == 1
  return 1 if n == 2
  a, b, c = 0, 0, 1
  (3..n).each { d = a + b + c; a, b, c = b, c, d }
  c
end