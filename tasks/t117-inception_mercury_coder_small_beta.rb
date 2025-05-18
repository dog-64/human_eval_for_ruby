def select_words(s, n)
  consonants = 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ'
  words = s.split
  words.select { |word| word.count(consonants) == n }
end