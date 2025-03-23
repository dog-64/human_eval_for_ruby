
def encrypt(s)
  result = ''
  s.each_char do |char|
    if 'a'..'z' === char
      shift = (char.ord - 'a'.ord + 1) * 2
      encrypted_char = ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
      result += encrypted_char
    else
      result += char
    end
  end
  result
end
