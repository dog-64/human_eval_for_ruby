def factorize(n)
  factors = []
  if n < 0
    factors << -1
    n = -n
  end
  return factors if n == 1

  divisor = 2
  while divisor <= n
    if n % divisor == 0
      factors << divisor
      n /= divisor
    else
      divisor += 1
    end
  end
  factors
end