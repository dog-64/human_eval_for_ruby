def select_words(s, n)
  words = s.split(" ")
  result = []
  words.each do |word|
    if word.count("aeiou") == n
      result << word
    end
  end
  return result
end