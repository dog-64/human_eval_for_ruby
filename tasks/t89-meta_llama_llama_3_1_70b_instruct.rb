def encrypt(s)
  s.chars.map do |c|
    next c unless c =~ /[a-z]/
    shift = (c.ord - 96) * 2
    (((c.ord - 97 + shift) % 26) + 97).chr
  end.join
end