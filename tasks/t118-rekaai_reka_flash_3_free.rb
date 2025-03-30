
def get_closest_vowel(word)
  vowels = %w[a e i o u A E I O U]
  (1...word.length-1).reverse_each do |i|
    next unless vowels.include?(word[i])
    next if vowels.include?(word[i-1]) || vowels.include?(word[i+1])
    return word[i]
  end
  ""
end

 