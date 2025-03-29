def anti_shuffle(s)
  s.split(/(\s+)/).map do |word|
    word.match?(/\s/) ? word : word.chars.sort_by(&:ord).join
  end.join
end