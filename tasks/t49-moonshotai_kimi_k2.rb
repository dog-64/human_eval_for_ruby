def modp(n, p)
  return 0 if p == 1
  return 1 if n == 0
  
  result = 1
  base = 2 % p
  
  while n > 0
    if n.odd?
      result = (result * base) % p
    end
    base = (base * base) % p
    n = n >> 1
  end
  
  result
end