def modp(n, p)
  result = 1
  base = 2 % p
  while n > 0
    result = (result * base) % p if (n & 1) == 1
    base = (base * base) % p
    n >>= 1
  end
  result
end