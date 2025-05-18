def vowels_count(word)
  vowels = 'aeiou'
  count = 0
  word.each_char.with_index do |char, index|
    if vowels.include?(char.downcase) || (char.downcase == 'y' && index == word.length - 1)
      count += 1
    end
  end
  count
end