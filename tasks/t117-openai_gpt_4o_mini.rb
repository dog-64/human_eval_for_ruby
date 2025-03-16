def select_words(s, n)
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
  s.split.select { |word| word.chars.count { |char| consonants.include?(char) } == n }
end