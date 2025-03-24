def string_xor(a, b)
  a = a.empty? ? b : a
  b = b.empty? ? a : b
  a.chars.zip(b.chars).map { |x, y| (x.to_i(2) ^ y.to_i(2)).to_s(2) }.join
end