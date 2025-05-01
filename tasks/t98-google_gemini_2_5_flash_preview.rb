def count_upper(s)
  count = 0
  vowels = "AEIOU"
  s.each_char.with_index do |char, index|
    if index.even? && vowels.include?(char)
      count += 1
    end
  end
  count
end