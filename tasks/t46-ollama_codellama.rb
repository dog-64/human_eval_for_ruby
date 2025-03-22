def fib4(n)
  return 0 if n == 0 || n == 1
  return 2 if n == 2
  return 0 if n == 3
  fib4(n-1) + fib4(n-2) + fib4(n-3) + fib4(n-4)
end