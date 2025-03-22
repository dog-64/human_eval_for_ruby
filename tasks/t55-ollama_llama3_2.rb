def fib(n)
  return 1 if n == 1
  return 0 if n == 0
  (n - 1).downto(1) { |i| yield i }
end