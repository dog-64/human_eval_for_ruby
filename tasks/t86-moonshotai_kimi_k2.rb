def anti_shuffle(s)
  s.split(/(\s+)/).map { |word| word.strip.empty? ? word : word.chars.sort.join }.join
end