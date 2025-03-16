def select_words(s, n)
  s.split.select { |word| word.count("bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ") == n }
end