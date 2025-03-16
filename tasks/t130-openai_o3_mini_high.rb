def tri(n)
  m = n.even? ? n : n + 1
  seq = Array.new(m + 1)
  0.step(m, 2) { |i| seq[i] = 1 + i / 2 }
  seq[1] = 3 if m >= 1
  (3..m - 1).step(2) { |i| seq[i] = seq[i - 1] + seq[i - 2] + seq[i + 1] }
  seq[0..n]
end