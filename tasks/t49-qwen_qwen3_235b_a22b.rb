def modp(n, p)
  return 1 % p if n == 0

  result = 1
  base = 2 % p
  exponent = n

  while exponent > 0
    result = (result * base) % p if exponent.odd?
    base = (base * base) % p
    exponent /= 2
  end

  result
end