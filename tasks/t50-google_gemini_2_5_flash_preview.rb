def decode_shift(s)
  decoded_string = ""
  s.each_char do |char|
    decoded_char_code = char.ord - 5
    if decoded_char_code < 'a'.ord
      decoded_char_code += 26
    end
    decoded_string += decoded_char_code.chr
  end
  decoded_string
end