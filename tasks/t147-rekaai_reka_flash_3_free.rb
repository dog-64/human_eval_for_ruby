
def get_max_triples(n)
  return 0 if n < 3

  count0 = 0
  count1 = 0

  (0...n).each do |i|
    count0 += 1 if i % 3 == 0
    count1 += 1 unless i % 3 == 0
  end

  triples0 = count0 * (count0 - 1) * (count0 - 2) / 6
  triples1 = count1 * (count1 - 1) * (count1 - 2) / 6

  triples0 + triples1
end

 