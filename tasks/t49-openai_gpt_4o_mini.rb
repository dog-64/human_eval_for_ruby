def modp(n, p)
  return 1 if n == 0
  result = 1
  base = 2 % p
  while n > 0
    if n.odd?
      result = (result * base) % p
    end
    base = (base * base) % p
    n >>= 1
  end
  result
end