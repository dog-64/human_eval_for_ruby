def encode(message)
  vowels = "aeiouAEIOU"
  encoded_message = message.chars.map do |char|
    if char.match?(/[a-zA-Z]/)
      if char == char.downcase
        char = char.upcase
      else
        char = char.downcase
      end
      if vowels.include?(char)
        (char.ord + 2).chr
      else
        char
      end
    else
      char
    end
  end.join
end