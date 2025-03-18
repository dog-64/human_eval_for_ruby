def anti_shuffle(s)
  s.split.sort_by { |word| word.chars.map(&:ord) }.join(" ")
end