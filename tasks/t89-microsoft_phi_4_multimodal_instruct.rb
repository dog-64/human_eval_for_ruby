def encrypt(s)
  encrypted = s.chars.map do |char|
    if char.between?('a', 'z')
      shift = (char.ord - 'a'.ord + 1) * 2
      new_char = ('a'.ord + (shift % 26) - 1).chr
      new_char
    else
      char
    end
  end.join
  encrypted
end
