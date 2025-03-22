def anti_shuffle(s)
  s.split(/(\s+)/).map { |word| word.match?(/\S/) ? word.chars.sort.join : word }.join
end