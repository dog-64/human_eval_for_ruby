def anti_shuffle(s)
  return s if s.empty?

  words = s.split(' ')
  sorted_words = words.map do |word|
    word.chars.sort.join
  end

  sorted_words.join(' ')
end