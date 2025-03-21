def get_closest_vowel(word)
  vowels = 'aeiouAEIOU'
  word.chars.each_cons(3).reverse.each do |chars|
    return chars[1] if vowels.include?(chars[1]) && !vowels.include?(chars[0]) && !vowels.include?(chars[2])
  end
  ""
end