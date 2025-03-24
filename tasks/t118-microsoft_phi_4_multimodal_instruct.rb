def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  word.reverse.each_char.with_index do |char, index|
    if vowels.include?(char) && index != word.length - 1
      return char
    elsif char.match?(/[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]/)
      return nil
    end
  end
  ""
end
