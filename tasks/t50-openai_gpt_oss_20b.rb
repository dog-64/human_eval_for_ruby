def decode_shift(s)
  s.chars.map do |c|
    idx = c.ord - 'a'.ord
    new_idx = (idx - 5) % 26
    (new_idx + 'a'.ord).chr
  end.join
end