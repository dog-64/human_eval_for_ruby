def vowels_count(word)
  vowels = 'aeiouAEIOU'
  count = 0
  word.each_char.with_index do |char, index|
    if vowels.include?(char)
      count += 1
    elsif char == 'y' && index == word.length - 1
      count += 1
    end
  end
  count
end