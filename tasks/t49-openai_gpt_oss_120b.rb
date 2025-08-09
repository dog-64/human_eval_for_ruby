def modp(n, p)
  return 0 if p == 1
  result = 1 % p
  base = 2 % p
  while n > 0
    result = (result * base) % p if (n & 1) == 1
    base = (base * base) % p
    n >>= 1
  end
  result
end