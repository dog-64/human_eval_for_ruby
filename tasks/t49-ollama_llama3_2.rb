def modp(n, p)
  return 1 if n == 0
  (modp(n / 2, p) * (n % 2 + 1)) % p
end