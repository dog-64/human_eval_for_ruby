
def fibfib(n)
  return 0 if n <= 1
  return 1 if n == 2
  
  a, b, c = 0, 0, 1
  (3..n).each do
    next_val = a + b + c
    a, b, c = b, c, next_val
  end
  c
end