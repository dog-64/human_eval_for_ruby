def vowels_count(word)
  return 0 if word.empty?
  
  vowels = %w[a e i o u A E I O U]
  count = word.chars.count { |char| vowels.include?(char) }
  
  count += 1 if word[-1].downcase == 'y'
  
  count
end