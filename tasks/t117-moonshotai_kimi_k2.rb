def select_words(s, n)
  return [] if s.empty?
  
  consonants = 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ'
  words = s.split
  
  words.select { |word| word.count(consonants) == n }
end