def anti_shuffle(s)
  words = s.split
  sorted_words = words.map(&:chars).sort.map(&:join)
  sorted_words.join(' ')
end
