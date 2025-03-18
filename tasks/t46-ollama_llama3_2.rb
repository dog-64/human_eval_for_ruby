def fib4(n)
  return n == 0 || n == 1 ? 0 : (n - 3 >= 0 ? fib4(n - 3) + fib4(n - 2) + fib4(n - 1) + fib4(n - 4) : 0)
end