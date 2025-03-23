
def decode_shift(s)
  result = ""
  s.each_char do |char|
    decoded_char = ((char.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr
    result += decoded_char
  end
  result
end
