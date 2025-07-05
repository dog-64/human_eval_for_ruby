def encrypt(s)
  encrypted_chars = s.chars.map do |char|
    if char.match?(/[a-z]/)
      alphabet_position = char.ord - 'a'.ord + 1
      shift_amount = alphabet_position * 2
      shifted_ord = 'a'.ord + (char.ord - 'a'.ord + shift_amount) % 26
      shifted_ord.chr
    else
      char
    end
  end
  encrypted_chars.join
end