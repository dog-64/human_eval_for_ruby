def decode_shift(s)
  s.chars.map { |c| (c.ord - 5 - 'a'.ord) % 26 + 'a'.ord }.map(&:chr).join
end