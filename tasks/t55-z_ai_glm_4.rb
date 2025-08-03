
def fib(n)
  return 1 if n <= 2
  a, b = 1, 1
  (3..n).each do
    a, b = b, a + b
  end
  b
end