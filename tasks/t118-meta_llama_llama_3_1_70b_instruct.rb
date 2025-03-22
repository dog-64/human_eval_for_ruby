def get_closest_vowel(word)
  vowels = 'aeiouAEIOU'
  consonants = 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ'
  word.reverse.each_cons(3).lazy.map { |a, b, c| [a, b, c].join if consonants.include?(a) && vowels.include?(b) && consonants.include?(c) }.find { |x| !x.nil? }&.[](1)
end