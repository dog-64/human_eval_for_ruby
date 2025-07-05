def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"

  (word.length - 3).downto(0) do |i|
    char1 = word[i]
    char2 = word[i + 1]
    char3 = word[i + 2]

    if consonants.include?(char1) && vowels.include?(char2) && consonants.include?(char3)
      return char2
    end
  end
  ""
end