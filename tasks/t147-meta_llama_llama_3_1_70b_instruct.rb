def get_max_triples(n)
  return 0 if n < 3
  a = (1..n).map { |i| i * i - i + 1 }
  a.combination(3).count { |x, y, z| (x + y + z) % 3 == 0 }
end