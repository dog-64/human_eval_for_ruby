def encrypt(s)
  encrypted_string = ""
  s.each_char.with_index do |char, index|
    if char.match?(/[a-z]/)
      shift = (char.ord - 'a'.ord + 1) * 2
      encrypted_char_ord = 'a'.ord + (char.ord - 'a'.ord + shift) % 26
      encrypted_string += encrypted_char_ord.chr
    else
      encrypted_string += char
    end
  end
  encrypted_string
end