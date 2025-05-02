def decode_shift(s)
  s.chars.map do |c|
    ord = c.ord
    shifted = ord - 5
    shifted += 26 if shifted < 'a'.ord
    shifted.chr
  end.join
end