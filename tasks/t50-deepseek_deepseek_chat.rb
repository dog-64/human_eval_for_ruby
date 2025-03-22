def decode_shift(s)
  s.chars.map { |c| ((c.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr }.join
end