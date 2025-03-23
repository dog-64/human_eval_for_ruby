
def encode(message)
  encoded_message = ""
  message.each_char do |char|
    if char.match?(/[aeiouAEIOU]/)
      if char == 'a' || char == 'A'
        encoded_message += 'c'
      elsif char == 'e' || char == 'E'
        encoded_message += 'g'
      elsif char == 'i' || char == 'I'
        encoded_message += 'k'
      elsif char == 'o' || char == 'O'
        encoded_message += 'q'
      elsif char == 'u' || char == 'U'
        encoded_message += 'w'
      else
        encoded_message += char
      end
    else
      if char.match?(/[a-z]/)
        encoded_message += char.upcase
      else
        encoded_message += char.downcase
      end
    end
  end
  encoded_message
end
