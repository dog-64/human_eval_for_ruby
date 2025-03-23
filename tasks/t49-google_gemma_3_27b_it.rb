def modp(n, p)
  result = 1
  base = 2 % p
  while n > 0
    if n % 2 == 1
      result = (result * base) % p
    end
    base = (base * base) % p
    n /= 2
  end
  result
end