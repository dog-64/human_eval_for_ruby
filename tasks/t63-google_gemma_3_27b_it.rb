def fibfib(n)
  return 0 if n == 0
  return 0 if n == 1
  return 1 if n == 2

  a, b, c = 0, 0, 1
  (3..n).each do |i|
    d = a + b + c
    a, b, c = b, c, d
  end
  c
end