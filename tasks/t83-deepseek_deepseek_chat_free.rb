def starts_one_ends(n)
  return 1 if n == 1
  total = 0
  total += 9 ** (n - 1) 
  total += 9 ** (n - 1)
  total -= 8 ** (n - 1)
  total
end