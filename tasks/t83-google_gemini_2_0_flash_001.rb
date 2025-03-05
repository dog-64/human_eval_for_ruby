def starts_one_ends(n)
  if n == 1
    return 1
  end

  total_starts_one = 10**(n-1)
  total_ends_one = 10**(n-1)
  total_both = 10**(n-2)

  return total_starts_one + total_ends_one - total_both
end