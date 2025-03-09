def count_upper(s)
  count = 0
  s.chars.each_with_index do |char, index|
    if index.even? && ['A', 'E', 'I', 'O', 'U'].include?(char)
      count += 1
    end
  end
  count
end
