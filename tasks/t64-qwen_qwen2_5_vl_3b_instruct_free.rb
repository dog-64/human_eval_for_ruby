def vowels_count(word)
  vowels = ['a', 'e', 'i', 'o', 'u', 'y']
  count = 0
  word.each_char do |char|
    count += 1 if vowels.include?(char.downcase) && !char == 'y'
  end
  count
end