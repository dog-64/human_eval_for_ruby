def vowels_count(word)
  vowels = %w[a e i o u]
  count = 0
  word.chars.each_with_index do |char, index|
    count += 1 if vowels.include?(char) || (char.downcase == 'y' && index == word.length - 1)
  end
  count
end