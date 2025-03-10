def encrypt(s)
  s.chars.map do |char|
    shift = (char.ord - 'a'.ord + 1) * 2
    new_char = (char.ord + shift)
    new_char > 'z'.ord ? (new_char - 26).chr : new_char.chr
  end.join
end