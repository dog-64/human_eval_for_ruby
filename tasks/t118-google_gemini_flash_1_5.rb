def get_closest_vowel(word)
  vowels = "AEIOUaeiou"
  word.reverse.each_char.with_index do |char, index|
    if vowels.include?(char) && index > 0 && index < word.length -1 && !vowels.include?(word.reverse[index-1]) && !vowels.include?(word.reverse[index+1])
      return char
    end
  end
  ""
end
