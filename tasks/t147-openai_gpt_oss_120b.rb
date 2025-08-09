def get_max_triples(n)
  return 0 if n < 3
  base = n / 3
  rem = n % 3
  count_mod0 = base + (rem > 0 ? 1 : 0)
  count_mod1 = base + (rem > 1 ? 1 : 0)
  cnt0 = count_mod1
  cnt1 = n - cnt0
  c0 = cnt0 >= 3 ? cnt0 * (cnt0 - 1) * (cnt0 - 2) / 6 : 0
  c1 = cnt1 >= 3 ? cnt1 * (cnt1 - 1) * (cnt1 - 2) / 6 : 0
  c0 + c1
end