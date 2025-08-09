def starts_one_ends(n)
  return 0 if n <= 0
  return 1 if n == 1
  start_cnt = 10 ** (n - 1)
  end_cnt = 9 * (10 ** (n - 2))
  overlap = 10 ** (n - 2)
  start_cnt + end_cnt - overlap
end