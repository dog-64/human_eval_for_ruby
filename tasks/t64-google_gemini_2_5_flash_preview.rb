def vowels_count(word)
  count = 0
  vowels = "aeiouAEIOU"
  word.each_char.with_index do |char, index|
    if vowels.include?(char)
      count += 1
    elsif char.downcase == 'y' && index == word.length - 1
      count += 1
    end
  end
  count
end