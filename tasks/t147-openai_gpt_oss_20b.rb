def get_max_triples(n)
  return 0 if n < 3
  c0 = (n + 1) / 3
  c1 = n - c0
  c0_comb = c0 >= 3 ? c0 * (c0 - 1) * (c0 - 2) / 6 : 0
  c1_comb = c1 >= 3 ? c1 * (c1 - 1) * (c1 - 2) / 6 : 0
  c0_comb + c1_comb
end