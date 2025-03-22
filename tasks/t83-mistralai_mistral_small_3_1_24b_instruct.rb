def starts_one_ends(n)
  if n == 1
    return 2
  end

  starts_with_one = 10**(n-1)
  ends_with_one = 10**(n-1) - 1

  total = starts_with_one + ends_with_one

  if n > 1
    total += 8 * 10**(n-2)
  end

  total
end