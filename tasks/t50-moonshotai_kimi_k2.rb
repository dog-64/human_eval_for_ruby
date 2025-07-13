def decode_shift(s)
  s.chars.map do |char|
    shifted = char.ord - 5
    shifted < 97 ? shifted + 26 : shifted
  end.map(&:chr).join
end