def starts_one_ends(n)
  return 2 if n == 1
  10**(n - 1) + 8 * 10**(n - 2)
end