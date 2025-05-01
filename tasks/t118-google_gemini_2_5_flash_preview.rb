def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"

  (1...word.length - 1).to_a.reverse.each do |i|
    if vowels.include?(word[i]) && consonants.include?(word[i - 1]) && consonants.include?(word[i + 1])
      return word[i]
    end
  end

  ""
end
