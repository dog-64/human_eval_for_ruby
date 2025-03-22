def starts_one_ends(n)
  return 2 if n == 1
  start_count = 9 * 10**(n - 2)
  end_count = 10**(n - 1)
  total_count = start_count + end_count
  total_count + 9 * 10**(n - 2)
end