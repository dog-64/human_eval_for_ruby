def starts_one_ends(n)
  if n == 1
    return 2
  end
  9 * (10**(n-2)) + 9 * (10**(n-2)) - (10**(n-2))
end
