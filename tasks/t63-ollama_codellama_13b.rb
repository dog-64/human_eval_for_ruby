def fibfib(n)
  return 0 if n == 0
  return 0 if n == 1
  return 1 if n == 2
  return fibfib(n-1) + fibfib(n-2) + fibfib(n-3)
end