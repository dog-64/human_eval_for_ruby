def anti_shuffle(s)
  s.split.map { |word| word.chars.sort.join }.join(' ')
end
