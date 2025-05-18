def encode(message)
  vowels = 'aeiouAEIOU'
  encoded_message = message.chars.map do |char|
    if vowels.include?(char)
      next_char = (char.ord + 2).chr
      char.swapcase == char.upcase ? next_char.upcase : next_char.downcase
    else
      char.swapcase
    end
  end.join
  encoded_message
end