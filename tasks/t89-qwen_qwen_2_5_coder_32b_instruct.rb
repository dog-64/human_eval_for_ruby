def encrypt(s)
  s.chars.map do |char|
    shift = (char.ord - 'a'.ord + 1) * 2
    ('a'.ord + (char.ord - 'a'.ord + shift) % 26).chr
  end.join
end