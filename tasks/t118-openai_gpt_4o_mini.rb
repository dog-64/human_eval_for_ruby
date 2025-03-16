def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  last_consonant_index = word.length - 1
  while last_consonant_index > 0
    if vowels.include?(word[last_consonant_index])
      last_consonant_index -= 1
      next
    end

    first_consonant_index = last_consonant_index - 1
    while first_consonant_index > 0
      if vowels.include?(word[first_consonant_index])
        return word[first_consonant_index]
      elsif !vowels.include?(word[first_consonant_index])
        break
      end
      first_consonant_index -= 1
    end
    last_consonant_index -= 1
  end
  ""
end