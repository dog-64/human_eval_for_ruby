def encrypt(s)
  s.chars.map do |char|
    if char =~ /[a-z]/
      shift = (char.ord - 'a'.ord + 1) * 2
      ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
    else
      char
    end
  end.join
end
