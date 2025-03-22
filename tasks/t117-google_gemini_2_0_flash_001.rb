def select_words(s, n)
  return [] if s.empty?

  words = s.split
  result = []

  words.each do |word|
    consonant_count = word.chars.count { |char| char =~ /[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]/ }
    result << word if consonant_count == n
  end

  result
end