
def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  (word.length - 2).downto(0) do |i|
    if vowels.include?(word[i]) && !vowels.include?(word[i - 1]) && !vowels.include?(word[i + 1])
      return word[i]
    end
  end
  ""
end
