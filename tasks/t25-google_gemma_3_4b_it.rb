def factorize(n)
  if n == 1
    return []
  end

  factors = []
  n = Float(n).abs

  if n < 0
    factors << -1
    n = -n
  end

  i = 2
  while i * i <= n
    while n % i == 0
      factors << i
      n /= i
    end
    i += 1
  end

  if n > 1
    factors << n
  end

  factors
end
