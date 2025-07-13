def encode(message)
  vowels = 'aeiouAEIOU'
  message.chars.map do |char|
    new_char = char.swapcase
    if vowels.include?(new_char)
      new_char = (new_char.ord + 2).chr
    end
    new_char
  end.join
end