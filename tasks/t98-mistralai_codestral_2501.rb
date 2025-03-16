def count_upper(s)
  vowels = 'AEIOU'
  count = 0
  s.each_char.with_index do |char, index|
    count += 1 if index.even? && vowels.include?(char)
  end
  count
end