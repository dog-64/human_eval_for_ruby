def decode_shift(s)
  s.chars.map { |c| (c.ord - 5).chr }.join
end