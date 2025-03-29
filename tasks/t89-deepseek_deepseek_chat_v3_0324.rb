def encrypt(s)
  s.chars.map do |c|
    shift = (c.ord - 'a'.ord + 1) * 2
    new_ord = 'a'.ord + (c.ord - 'a'.ord + shift) % 26
    new_ord.chr
  end.join
end