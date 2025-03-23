def starts_one_ends(n)
  if n == 1
    return 2
  end

  total = 9 * (10**(n - 2))
  total += 10**(n - 1) - 10**(n - 2)
  total
end