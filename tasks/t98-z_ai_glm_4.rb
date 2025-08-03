
def count_upper(s)
  vowels = %w[A E I O U]
  count = 0
  s.each_char.with_index do |char, index|
    if index.even? && vowels.include?(char)
      count += 1
    end
  end
  count
end