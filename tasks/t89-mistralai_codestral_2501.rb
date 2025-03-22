def encrypt(s)
  s.chars.map.with_index do |char, index|
    shift = (index + 1) * 2
    ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
  end.join
end