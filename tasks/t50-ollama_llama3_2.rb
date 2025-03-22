def decode_shift(s)
  s.chars.map { |c| c.ord - 5 }.map! { _1.chr }
end