def fibfib(n)
  return 0 if n < 2
  a, b, c = 0, 1, 1
  (n - 2).times do |i|
    a, b, c = b, c, a + b + c
  end
  c
end