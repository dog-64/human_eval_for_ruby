def select_words(s, n)
  words = s.split
  result = []
  words.each do |word|
    consonant_count = 0
    word.each_char do |char|
      if !['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].include?(char)
        consonant_count += 1
      end
    end
    if consonant_count == n
      result << word
    end
  end
  result
end
