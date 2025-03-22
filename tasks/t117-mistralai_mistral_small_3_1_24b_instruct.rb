def select_words(s, n)
  vowels = 'aeiouAEIOU'
  s.split.select do |word|
    word.count { |char| char =~ /[[:alpha:]]/ && !vowels.include?(char) } == n
  end
end