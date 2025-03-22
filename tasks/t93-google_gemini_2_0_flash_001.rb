def encode(message)
  encoded_message = ""
  message.each_char do |char|
    if char =~ /[aeiouAEIOU]/
      if char == 'a'
        encoded_message += 'c'
      elsif char == 'e'
        encoded_message += 'g'
      elsif char == 'i'
        encoded_message += 'k'
      elsif char == 'o'
        encoded_message += 'q'
      elsif char == 'u'
        encoded_message += 'w'
      elsif char == 'A'
        encoded_message += 'C'
      elsif char == 'E'
        encoded_message += 'G'
      elsif char == 'I'
        encoded_message += 'K'
      elsif char == 'O'
        encoded_message += 'Q'
      elsif char == 'U'
        encoded_message += 'W'
      end
    elsif char =~ /[a-z]/
      encoded_message += char.upcase
    elsif char =~ /[A-Z]/
      encoded_message += char.downcase
    else
      encoded_message += char
    end
  end
  encoded_message
end