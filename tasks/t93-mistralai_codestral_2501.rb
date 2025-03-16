def encode(message)
  vowels = 'aeiouAEIOU'
  shifted_vowels = 'cgkqwCGKQW'

  message.chars.map do |char|
    if vowels.include?(char)
      shifted_vowels[vowels.index(char)]
    else
      char.swapcase
    end
  end.join
end