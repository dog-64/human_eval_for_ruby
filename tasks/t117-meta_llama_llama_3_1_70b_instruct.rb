def select_words(s, n)
  s.split.select do |word|
    word.downcase.count('bcdfghjklmnpqrstvwxyz') == n
  end
end