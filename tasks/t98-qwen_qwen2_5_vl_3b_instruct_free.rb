def count_upper(s)
  vowels = ['A', 'E', 'I', 'O', 'U']
  count = 0
  s.each_char.with_index do |char, index|
    if vowels.include?(char) && index.even?
      count += 1
    end
  end
  count
end