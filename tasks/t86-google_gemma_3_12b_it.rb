def anti_shuffle(s)
  s.split(/\s+/).map { |word| word.chars.sort.join }.join(' ')
end
