def select_words(s, n)
  s.split(' ').select { |word| word.match(/[aeiouAEIOU]/).count == n }
end
