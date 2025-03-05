def encrypt(s)
  encrypted = ""
  s.each_char do |char|
    if char >= 'a' && char <= 'z'
      pos = char.ord - 'a'.ord + 1
      shift = (2 * pos) % 26
      encrypted_char = ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
      encrypted += encrypted_char
    else
      encrypted += char
    end
  end
  encrypted
end