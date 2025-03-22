def count_upper(s)
  vowels = ['A', 'E', 'I', 'O', 'U']
  count = 0
  s.chars.each_with_index do |char, index|
    if index.even? && vowels.include?(char)
      count += 1
    end
  end
  count
end
