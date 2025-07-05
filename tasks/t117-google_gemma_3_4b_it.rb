def select_words(s, n)
  words = s.split
  result = []
  words.each do |word|
    count = 0
    word.each_char do |char|
      if ['a', 'e', 'i', 'o', 'u'].include?(char.downcase)
        next
      else
        count += 1
      end
    end
    if count == n
      result << word
    end
  end
  result
end
