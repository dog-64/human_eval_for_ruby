def count_upper(s)
  vowels = ['A', 'E', 'I', 'O', 'U']
  s.chars.each_with_index.count { |char, index| index.even? && vowels.include?(char) }
end