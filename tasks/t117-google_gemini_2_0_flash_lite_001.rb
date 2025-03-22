def select_words(s, n)
  return [] if s.empty?

  vowels = "aeiouAEIOU"
  s.split.select do |word|
    consonant_count = word.chars.count { |char| !vowels.include?(char) }
    consonant_count == n
  end
end