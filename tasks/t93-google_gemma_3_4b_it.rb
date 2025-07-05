def encode(message)
  encoded_message = ""
  message.each_char do |char|
    if ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].include?(char)
      new_char = (char.ord - 32) % 26 + 'a'.ord
      encoded_message += new_char.chr
    else
      new_char = char.downcase
      encoded_message += new_char.upcase
    end
  end
  encoded_message
end
