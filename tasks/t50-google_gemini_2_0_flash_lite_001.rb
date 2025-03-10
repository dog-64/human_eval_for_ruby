def decode_shift(s)
  s.each_char.map do |char|
    (((char.ord - 'a'.ord - 5) % 26) + 'a'.ord).chr
  end.join
end