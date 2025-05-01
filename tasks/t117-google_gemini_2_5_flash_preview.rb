def select_words(s, n)
  return [] if s.empty?

  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
  s.split.select do |word|
    consonant_count = word.chars.count { |char| consonants.include?(char) }
    consonant_count == n
  end
end