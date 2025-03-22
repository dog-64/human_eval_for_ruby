def factorize(n)
  return [] if n == 1
  factors = []
  if n < 0
    factors << -1
    n = -n
  end
  
  d = 2
  while d * d <= n
    while n % d == 0
      factors << d
      n /= d
    end
    d += 1
  end
  factors << n if n > 1
  factors
end