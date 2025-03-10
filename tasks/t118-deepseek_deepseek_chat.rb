def get_closest_vowel(word)
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  consonants = ('a'..'z').to_a + ('A'..'Z').to_a - vowels
  word.chars.each_with_index do |char, index|
    next if index == 0 || index == word.length - 1
    if vowels.include?(char) && consonants.include?(word[index - 1]) && consonants.include?(word[index + 1])
      return char
    end
  end
  ""
end