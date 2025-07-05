def vowels_count(word)
  count = 0
  word.each_char do |char|
    if ['a', 'e', 'i', 'o', 'u', 'y'].include?(char.downcase)
      count += 1
    end
  end
  count
end
