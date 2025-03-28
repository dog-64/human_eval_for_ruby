def encode(message)
  vowels = ['a', 'e', 'i', 'o', 'u']
  message.chars.map do |char|
    if vowels.include?(char.downcase)
      new_char = char.downcase.ord + 2
      new_char = new_char.chr
      char == char.upcase ? new_char.upcase : new_char
    else
      char.swapcase
    end
  end.join
end