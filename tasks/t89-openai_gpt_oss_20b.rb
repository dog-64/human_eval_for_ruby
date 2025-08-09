def encrypt(s)
  s.chars.map do |c|
    ((c.ord - 97 + 4) % 26 + 97).chr
  end.join
end