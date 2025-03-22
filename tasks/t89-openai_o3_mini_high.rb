def encrypt(s)
  s.chars.map { |char| (((char.ord - 97) + 4) % 26 + 97).chr }.join
end