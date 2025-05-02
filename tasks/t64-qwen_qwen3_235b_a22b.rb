def vowels_count(word)
  count = 0
  word.chars.each_with_index do |char, index|
    if 'aeiouAEIOU'.include?(char)
      count += 1
    elsif index == word.length - 1 && 'yY'.include?(char)
      count += 1
    end
  end
  count
end