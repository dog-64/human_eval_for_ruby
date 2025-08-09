def count_upper(s)
  vowels = %w[A E I O U]
  count = 0
  s.each_char.with_index do |ch, i|
    count += 1 if i.even? && vowels.include?(ch)
  end
  count
end