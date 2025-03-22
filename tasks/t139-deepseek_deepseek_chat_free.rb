def factorial(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end

def special_factorial(n)
  (1..n).reduce(1) { |acc, i| acc * factorial(i) }
end