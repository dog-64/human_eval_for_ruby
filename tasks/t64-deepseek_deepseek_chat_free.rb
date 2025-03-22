def vowels_count(word)
  vowels = ['a', 'e', 'i', 'o', 'u']
  count = word.downcase.chars.count { |c| vowels.include?(c) }
  count += 1 if word.downcase.end_with?('y') && word.downcase != 'y'
  count
end