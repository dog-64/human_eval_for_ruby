def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  return "" if word.length < 3
  (word.length - 2).downto(1) do |i|
    char = word[i]
    next unless vowels.include?(char)
    left = word[i - 1]
    right = word[i + 1]
    unless vowels.include?(left) || vowels.include?(right)
      return char
    end
  end
  ""
end