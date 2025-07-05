def encode(message)
  vowels = 'aeiouAEIOU'
  encoded_message = message.chars.map do |char|
    if char =~ /[a-zA-Z]/
      new_char = char
      if vowels.include?(char)
        new_char = (char.ord + 2).chr
      end

      if ('a'..'z').include?(new_char)
        new_char = new_char.upcase
      elsif ('A'..'Z').include?(new_char)
        new_char = new_char.downcase
      end
      new_char
    else
      char
    end
  end
  encoded_message.join
end