def fibfib(n)
  return n if n < 3
  fibs = [0, 0, 1]
  (3..n).each do |i|
    fibs << fibs[i - 1] + fibs[i - 2] + fibs[i - 3]
  end
  fibs[n]
end