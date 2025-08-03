
_max_triples(n)
  return 0 if n < 3

  count0 = (n + 1) / 3
  count1 = n - count0

  c0 = count0 < 3 ? 0 : count0 * (count0 - 1) * (count0 - 2) / 6
  c1 = count1 < 3 ? 0 : count1 * (count1 - 1) * (count1 - 2) / 6

  c0 + c1
end