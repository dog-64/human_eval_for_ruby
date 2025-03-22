def factorize(n)
  return [] if n == 1
  factors = []
  factors << -1 if n < 0
  n = n.abs
  i = 2
  while i * i <= n
    while n % i == 0
      factors << i
      n /= i
    end
    i += 1
  end
  factors << n if n > 1
  factors
end