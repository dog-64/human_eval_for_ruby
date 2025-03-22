def decode_shift(s)
  s.chars.map { |c| (c.ord - 97 - 5) % 26 + 97 }.pack('c*')
end