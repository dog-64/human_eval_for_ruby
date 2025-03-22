def get_closest_vowel(word)
  vowels = "aeiouAEIOU"
  consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"

  word.chars.reverse.each_cons(3) do |a, b, c|
    return b if consonants.include?(a) && vowels.include?(b) && consonants.include?(c)
  end

  ""
end