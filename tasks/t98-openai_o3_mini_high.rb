def count_upper(s)
  vowels = 'AEIOU'
  s.chars.each_with_index.count { |char, i| i > 0 && i.even? && vowels.include?(char) }
end