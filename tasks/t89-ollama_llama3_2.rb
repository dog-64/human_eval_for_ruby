def encrypt(s)
  s.chars.map.with_index { |c, i| c.ord - 'a'.ord + (i + 1) * 2 }.map(&:chr).join
end