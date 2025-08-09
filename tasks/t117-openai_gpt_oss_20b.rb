def select_words(s, n)
  vowels = /[aeiouAEIOU]/
  s.split.select do |word|
    consonant_count = word.chars.count { |c| c =~ /[A-Za-z]/ && !c.match?(vowels) }
    consonant_count == n
  end
end