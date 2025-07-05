def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
  
  (word.length - 2).downto(1) do |i|
    if vowels.include?(word[i]) && consonants.include?(word[i - 1]) && consonants.include?(word[i + 1])
      return word[i]
    end
  end
  
  ""
end