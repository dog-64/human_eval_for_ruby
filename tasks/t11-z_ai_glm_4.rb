
string_xor(a, b)
  a.chars.zip(b.chars).map { |x, y| (x.to_i ^ y.to_i).to_s }.join
end