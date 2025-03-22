def digit_sum(s)
  s.each_char.sum { |char| ('A'..'Z').include?(char) ? char.ord : 0 }
end