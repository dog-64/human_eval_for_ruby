def anti_shuffle(s)
  s.split(' ').map do |word|
    word.chars.sort.join
  end.join(' ')
end