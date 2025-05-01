def fibfib(n)
  if n == 0
    return 0
  elsif n == 1
    return 0
  elsif n == 2
    return 1
  end

  a, b, c = 0, 0, 1
  (3..n).each do
    a, b, c = b, c, a + b + c
  end
  c
end
