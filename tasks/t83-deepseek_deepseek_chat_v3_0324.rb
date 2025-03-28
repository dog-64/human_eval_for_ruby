def starts_one_ends(n)
  return 1 if n == 0
  return 2 if n == 1
  9 * 10 ** (n - 1) + 9 * 10 ** (n - 1) - 9 * 10 ** (n - 2)
end