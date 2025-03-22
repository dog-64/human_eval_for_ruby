def decode_shift(s)
  decoded = ""
  s.each_char do |char|
    decoded_char = ((char.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr
    decoded += decoded_char
  end
  decoded
end