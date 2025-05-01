def get_closest_vowel(word)
  vowels = ['a', 'e', 'i', 'o', 'u']
  consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
  word.each_char.with_index do |char, index|
    if vowels.include?(char) && index > 0 && index < word.length - 1 && consonants.include?(word[index - 1]) && consonants.include?(word[index + 1])
      return char
    end
  end
  ""
end
