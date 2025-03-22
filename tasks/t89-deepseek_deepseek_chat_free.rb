def encrypt(s)
  s.chars.map do |c|
    shift = (c.ord - 'a'.ord + 1) * 2
    new_char = (c.ord + shift)
    if new_char > 'z'.ord
      new_char -= 26
    end
    new_char.chr
  end.join
end