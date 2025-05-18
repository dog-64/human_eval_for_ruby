def encrypt(s)
  s.chars.map do |char|
    if char.match?(/[a-z]/)
      shift = (char.ord - 'a'.ord + 1) * 2
      new_char = ((char.ord - 'a'.ord + shift) % 26).chr
      new_char
    else
      char
    end
  end.join
end