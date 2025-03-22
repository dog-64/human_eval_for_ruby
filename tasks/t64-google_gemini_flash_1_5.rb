def vowels_count(word)
  count = 0
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  word.each_char do |char|
    if vowels.include?(char)
      count += 1
    end
  end
  if word.length > 0 && ['y', 'Y'].include?(word[-1])
    count +=1
  end
  count
end
