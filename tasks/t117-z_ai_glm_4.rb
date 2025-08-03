
def select_words(s, n)
  return [] if s.empty?
  vowels = "aeiouAEIOU"
  s.split.select { |word| word.count("^aeiouAEIOU") == n }
end