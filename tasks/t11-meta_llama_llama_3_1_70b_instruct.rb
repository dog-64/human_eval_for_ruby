def string_xor(a, b)
  size = [a.size, b.size].min
  a[0, size].bytes.zip(b[0, size].bytes).map { |x, y| (x ^ y).chr }.join
end