def modp(n, p)
  return 1 if n == 0
  result = 2
  (n - 1).times { result *= 2 }
  result % p
end