def select_words(s, n)
  vowels = "aeiouAEIOU"
  s.split.select { |word| word.count { |char| !vowels.include?(char) } == n }
end