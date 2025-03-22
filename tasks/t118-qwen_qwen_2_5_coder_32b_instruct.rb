def get_closest_vowel(word)
  vowels = "AEIOUaeiou"
  length = word.length
  return "" if length < 3

  (length - 2).downto(1) do |i|
    if vowels.include?(word[i]) && !vowels.include?(word[i - 1]) && !vowels.include?(word[i + 1])
      return word[i]
    end
  end

  ""
end