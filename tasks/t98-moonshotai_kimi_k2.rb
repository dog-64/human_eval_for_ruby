def count_upper(s)
  vowels = ['A', 'E', 'I', 'O', 'U']
  count = 0
  s.chars.each_with_index do |char, index|
    count += 1 if index.even? && vowels.include?(char)
  end
  count
end