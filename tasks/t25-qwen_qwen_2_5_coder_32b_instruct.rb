def factorize(n)
  return [] if n == 1
  factors = []
  factors << -1 if n < 0
  n = n.abs
  divisor = 2
  while n > 1
    while n % divisor == 0
      factors << divisor
      n /= divisor
    end
    divisor += 1
  end
  factors
end