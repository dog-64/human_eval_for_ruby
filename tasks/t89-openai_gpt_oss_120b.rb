def encrypt(s)
  s.each_char.map { |c| ((c.ord - 97 + 4) % 26 + 97).chr }.join
end