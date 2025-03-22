def decode_shift(s)
  s.chars.map { |char| ((char.ord - 5 - 97) % 26 + 97).chr }.join
end