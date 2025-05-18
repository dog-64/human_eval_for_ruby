def decode_shift(s)
  s.chars.map { |char| (char.ord - 'a'.ord - 5 + 26) % 26 + 'a'.ord).chr }.join
end