def fib(n)
  return 0 if n == 1
  return 1 if n == 2
  fib(n - 1) + fib(n - 2)
end