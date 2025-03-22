def vowels_count(word)
  count = 0
  vowels = 'aeiouAEIOU'
  word.each_char do |char|
    if vowels.include?(char)
      count += 1
    elsif char == 'y' && word[-1] == char
      count += 1
    end
  end
  count
end