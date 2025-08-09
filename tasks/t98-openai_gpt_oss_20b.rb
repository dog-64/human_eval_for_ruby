def count_upper(s)
  vowels = ['A', 'E', 'I', 'O', 'U']
  count = 0
  s.each_char.with_index do |char, idx|
    count += 1 if idx.even? && vowels.include?(char)
  end
  count
end