def factorize(n)
  factors = []
  return factors if n == 0 || n == 1
  if n < 0
    factors << -1
    n = -n
  end
  i = 2
  while i * i <= n
    while (n % i).zero?
      factors << i
      n /= i
    end
    i += (i == 2 ? 1 : 2)
  end
  factors << n if n > 1
  factors
end