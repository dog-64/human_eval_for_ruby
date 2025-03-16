def count_upper(s)
  s.chars.each_with_index.count { |char, index| index.even? && 'AEIOU'.include?(char) }
end