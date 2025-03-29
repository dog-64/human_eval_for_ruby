def select_words(s, n)
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  s.split.select do |word|
    consonant_count = word.chars.count { |c| c =~ /[a-zA-Z]/ && !vowels.include?(c) }
    consonant_count == n
  end
end