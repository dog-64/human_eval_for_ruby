def encrypt(s)
  s.chars.map do |char|
    pos = char.ord - 'a'.ord + 1
    new_pos = (pos * 2 - 1) % 26
    (new_pos + 'a'.ord).chr
  end.join
end