def select_words(s, n)
  vowels = %w[a e i o u A E I O U]
  words = s.split
  words.select do |word|
    consonant_count = word.chars.count { |c| !vowels.include?(c) }
    consonant_count == n
  end
end