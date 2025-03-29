def get_closest_vowel(word)
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  consonants = ('a'..'z').to_a + ('A'..'Z').to_a - vowels

  (word.length - 2).downto(1) do |i|
    current_char = word[i]
    if vowels.include?(current_char)
      left_char = word[i - 1]
      right_char = word[i + 1]
      if consonants.include?(left_char) && consonants.include?(right_char)
        return current_char
      end
    end
  end

  ""
end