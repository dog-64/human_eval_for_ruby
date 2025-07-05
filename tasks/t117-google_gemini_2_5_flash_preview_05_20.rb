def select_words(s, n)
  return [] if s.empty?

  vowels = "aeiouAEIOU"
  s.split.select do |word|
    consonant_count = word.chars.count { |char| char.match?(/[a-zA-Z]/) && !vowels.include?(char) }
    consonant_count == n
  end
end