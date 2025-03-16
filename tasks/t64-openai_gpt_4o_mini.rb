def vowels_count(word)
  return 0 if word.empty?

  vowels = 'aeiou'
  count = 0

  word.each_char.with_index do |char, index|
    count += 1 if vowels.include?(char.downcase)
    count += 1 if char.downcase == 'y' && index == word.length - 1
  end

  count
end