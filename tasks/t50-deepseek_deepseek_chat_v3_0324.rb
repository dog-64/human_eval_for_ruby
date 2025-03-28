def decode_shift(s)
  s.chars.map do |c|
    shifted_ord = c.ord - 5
    shifted_ord < 'a'.ord ? (shifted_ord + 26).chr : shifted_ord.chr
  end.join
end