
def factorize(n)
  factors = []
  if n < 0
    factors << -1
    n = -n
  end
  return factors if n == 1

  while n % 2 == 0
    factors << 2
    n /= 2
  end

  d = 3
  while d * d <= n
    while n % d == 0
      factors << d
      n /= d
    end
    d += 2
  end

  factors << n if n > 1
  factors
end