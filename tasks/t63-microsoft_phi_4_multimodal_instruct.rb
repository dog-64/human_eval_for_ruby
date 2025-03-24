def fibfib(n)
  return n if n <= 2
  a, b, c = 0, 0, 1
  (n - 1).times do
    a, b, c = b, c, b + c + a
  end
  c
end