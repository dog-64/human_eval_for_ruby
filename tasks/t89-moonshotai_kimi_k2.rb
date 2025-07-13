def encrypt(s)
  s.chars.map do |char|
    pos = char.ord - 'a'.ord + 1
    shift = pos * 2
    new_pos = (char.ord - 'a'.ord + shift) % 26
    ('a'.ord + new_pos).chr
  end.join
end