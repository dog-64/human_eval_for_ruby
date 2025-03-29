def encode(message)
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  result = ''
  message.each_char do |char|
    if vowels.include?(char)
      char = (char.ord + 2).chr
    end
    result += char.upcase
  end
  result
end