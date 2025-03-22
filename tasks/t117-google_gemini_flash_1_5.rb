def select_words(s, n)
  s.split.select do |word|
    consonants = word.scan(/[^aeiouAEIOU]/).size
    consonants == n
  end
end
