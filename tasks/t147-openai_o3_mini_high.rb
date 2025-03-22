def get_max_triples(n)
  return 0 if n < 3
  count0 = (n + 1) / 3
  count1 = n - count0
  triples = 0
  triples += count0 * (count0 - 1) * (count0 - 2) / 6 if count0 >= 3
  triples += count1 * (count1 - 1) * (count1 - 2) / 6 if count1 >= 3
  triples
end