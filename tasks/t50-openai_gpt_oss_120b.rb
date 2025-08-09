def decode_shift(s)
  s.each_char.map { |c| ((c.ord - 97 - 5) % 26 + 97).chr }.join
end