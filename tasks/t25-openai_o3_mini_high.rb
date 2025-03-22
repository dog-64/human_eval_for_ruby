def factorize(n)
  factors = []
  if n < 0
    factors << -1
    n = -n
  end
  return factors if n <= 1
  while n % 2 == 0
    factors << 2
    n /= 2
  end
  divisor = 3
  while divisor * divisor <= n
    while n % divisor == 0
      factors << divisor
      n /= divisor
    end
    divisor += 2
  end
  factors << n if n > 1
  factors
end