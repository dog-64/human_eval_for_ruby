def special_factorial(n)
  return 1 if n == 1
  n * special_factorial(n-1)
end