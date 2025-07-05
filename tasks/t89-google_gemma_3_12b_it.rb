def encrypt(s)
  result = ''
  s.each_char do |char|
    if char.match?(/[a-z]/)
      position = char.ord - 'a'.ord + 1
      shift = 2 * position
      encrypted_char = (((char.ord - 'a'.ord + shift) % 26) + 'a'.ord).chr
      result += encrypted_char
    else
      result += char
    end
  end
  result
end
