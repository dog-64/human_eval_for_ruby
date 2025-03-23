
def factorize(n)
  return [] if n == 1

  factors = []
  sign = 1
  if n < 0
    sign = -1
    n = -n
  end

  if sign == -1
    factors << -1
  end

  d = 2
  while d * d <= n
    while n % d == 0
      factors << d
      n /= d
    end
    d += 1
  end

  if n > 1
    factors << n
  end

  return factors
end
