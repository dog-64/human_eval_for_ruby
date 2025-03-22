def modp(n, p)
  result = 1
  base = 2 % p
  while n > 0
    result = (result * base) % p if n.odd?
    base = (base * base) % p
    n /= 2
  end
  result
end