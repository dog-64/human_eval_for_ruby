def factorize(n)
  result = []
  if n < 0
    result << -1
    n = -n
  end
  i = 2
  while i * i <= n
    while n % i == 0
      result << i
      n /= i
    end
    i += 1
  end
  result << n if n > 1
  result
end