
def vowels_count(word)
  return 0 if word.empty?
  
  word_lower = word.downcase
  count = word_lower.count('aeiou')
  
  count += 1 if word_lower[-1] == 'y'
  
  count
end