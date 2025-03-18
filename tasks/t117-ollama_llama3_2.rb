def select_words(s, n)
  s.split.map { |word| word.size == n ? word : '' }.compact
end