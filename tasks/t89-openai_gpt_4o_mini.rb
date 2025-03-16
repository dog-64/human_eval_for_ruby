def encrypt(s)
  s.chars.map do |char|
    shift = (char.ord - 'a'.ord + 1) * 2
    new_char = ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
    new_char
  end.join
end