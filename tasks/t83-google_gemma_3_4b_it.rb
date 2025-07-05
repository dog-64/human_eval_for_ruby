def starts_one_ends(n)
  if n == 1
    return 2
  end

  start_nums = 10**(n - 1)
  end_nums = 10**n - 1

  if n == 2
    return 2
  end

  if n == 3
    return 18
  end

  start_count = 10**(n - 1)
  end_count = 10**n - 10**(n - 1)

  start_count + end_count
end
