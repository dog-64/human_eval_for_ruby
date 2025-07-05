def get_closest_vowel(word)
  vowels = %w[a e i o u A E I O U]
  vowel_index = -1

  (word.length - 1).downto(0) do |i|
    if !vowels.include?(word[i])
      if i == word.length - 1
        return ""
      end
      if !vowels.include?(word[i + 1])
        vowel_index = i
        break
      end
    end
  end

  if vowel_index != -1
    word[vowel_index]
  else
    ""
  end
end
