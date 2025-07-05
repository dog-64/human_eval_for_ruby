def count_upper(s)
  vowels = 'AEIOU'
  s.each_char.with_index.count { |char, index| index.even? && vowels.include?(char) }
end