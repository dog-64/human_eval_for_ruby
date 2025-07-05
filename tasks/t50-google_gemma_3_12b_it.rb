def decode_shift(s)
  decoded_string = ""
  s.each_char do |char|
    decoded_char = (char.ord - 5).chr
    decoded_string += decoded_char
  end
  decoded_string
end
