def vowels_count(word)
  vowels = ['a', 'e', 'i', 'o', 'u']
  count = 0
  word.each_char do |char|
    if vowels.include?(char.downcase)
      count += 1
    elsif char.downcase == 'y' && word.end_with?(char)
      count += 1
    end
  end
  count
end
