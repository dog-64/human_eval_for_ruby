def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
  
  word_length = word.length
  
  (word_length - 1).downto(1).each do |i|
    char = word[i]
    
    if vowels.include?(char)
      if i > 0 && i < word_length - 1
        prev_char = word[i - 1]
        next_char = word[i + 1]
        
        if consonants.include?(prev_char) && consonants.include?(next_char)
          return char
        end
      end
    end
  end
  
  ""
end
