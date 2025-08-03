
def get_closest_vowel(word)
  vowels = 'aeiouAEIOU'
  return "" if word.length < 3

  (word.length - 2).downto(1) do |i|
    current_char = word[i]
    if vowels.include?(current_char)
      left_char = word[i - 1]
      right_char = word[i + 1]
      if !vowels.include?(left_char) && !vowels.include?(right_char)
        return current_char
      end
    end
  end

  ""
end