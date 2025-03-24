def encode(message)
  vowels = 'aeiouAEIOU'
  encoded_chars = message.chars.map do |char|
    if vowels.include?(char)
      new_char = vowels[(vowels.index(char) + 2) % vowels.size]
      new_char.upcase! if char.islower?
      new_char
    else
      char.swapcase!
    end
  end
  encoded_chars.join
end