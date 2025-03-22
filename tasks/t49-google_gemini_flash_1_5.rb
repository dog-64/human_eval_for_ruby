def modp(n, p)
  return 1 if n == 0
  res = 1
  a = 2
  while n > 0
    if n % 2 == 1
      res = (res * a) % p
    end
    a = (a * a) % p
    n /= 2
  end
  res
end
