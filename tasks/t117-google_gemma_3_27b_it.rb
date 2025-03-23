
def select_words(s, n)
  words = s.split
  result = []
  vowels = "aeiouAEIOU"
  words.each do |word|
    consonant_count = 0
    word.each_char do |char|
      consonant_count += 1 unless vowels.include?(char)
    end
    result << word if consonant_count == n
  end
  result
end
