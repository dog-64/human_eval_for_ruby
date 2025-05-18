def modp(n, p)
  result = 1
  base = 2
  while n > 0
    if n.odd?
      result = (result * base) % p
    end
    base = (base * base) % p
    n >>= 1
  end
  result
end