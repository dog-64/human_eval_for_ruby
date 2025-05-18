def factorize(n)
  factors = []
  if n == 0
    return []
  end
  if n < 0
    factors << -1
    n = -n
  end
  if n == 1
    return factors
  end
  divisor = 2
  while divisor * divisor <= n
    while n % divisor == 0
      factors << divisor
      n = n / divisor
    end
    divisor += 1
  end
  if n > 1
    factors << n
  end
  factors
end