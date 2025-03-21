def encode(message)
  vowels = 'aeiouAEIOU'
  encoded_message = message.chars.map do |char|
    if vowels.include?(char)
      (char.ord + 2).chr
    else
      char.swapcase
    end
  end
  encoded_message.join
end