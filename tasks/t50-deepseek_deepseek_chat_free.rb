def decode_shift(s)
  s.chars.map { |c| (c.ord - 5 < 'a'.ord) ? (c.ord + 21).chr : (c.ord - 5).chr }.join
end