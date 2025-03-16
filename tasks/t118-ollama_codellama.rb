def get_closest_vowel(word)
  vowels = %w[a e i o u y]
  word.chars.each do |char|
    if char.match?(/[aeiouy]/i)
      return char
    end
  end
  ""
end