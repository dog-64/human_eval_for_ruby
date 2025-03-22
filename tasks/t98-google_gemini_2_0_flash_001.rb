def count_upper(s)
  count = 0
  vowels = ['A', 'E', 'I', 'O', 'U']
  s.chars.each_with_index do |char, index|
    if index.even? && vowels.include?(char)
      count += 1
    end
  end
  count
end