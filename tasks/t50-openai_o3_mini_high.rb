def decode_shift(s)
  s.chars.map { |ch| ((ch.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr }.join
end