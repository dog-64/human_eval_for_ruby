def encode(message)
  encoded_message = ""
  message.each_char do |char|
    if char.match?(/[a-z]/)
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
      else
        encoded_message += (char.ord + 2).chr
      end
    elsif char.match?(/[A-Z]/)
      if char == 'A'
        encoded_message += 'C'
      elsif char == 'E'
        encoded_message += 'G'
      elsif char == 'I'
        encoded_message += 'K'
      elsif char == 'O'
        encoded_message += 'Q'
      elsif char == 'U'
        encoded_message += 'W'
      else
        encoded_message += ((char.ord + 2) - 32).chr
      end
    else
      encoded_message += char
    end
  end
  encoded_message
end
