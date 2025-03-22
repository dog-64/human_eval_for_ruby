def modp(n, p)
  pow = 1
  base = 2
  while n > 0
    if n % 2 == 1
      pow = (pow * base) % p
    end
    base = (base * base) % p
    n /= 2
  end
  pow
end