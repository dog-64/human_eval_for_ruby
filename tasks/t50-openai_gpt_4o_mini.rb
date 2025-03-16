def decode_shift(s)
  s.chars.map do |char|
    ((char.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr
  end.join
end