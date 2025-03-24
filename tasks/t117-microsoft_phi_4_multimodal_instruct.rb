def select_words(s, n)
  s.split.each_char.with_object([]) do |char, arr|
    arr << char if char.match?(/[bcdfghjklmnpqrstvwxyz]/i)
  end.select { |word| word.count { |char| char.match?(/[bcdfghjklmnpqrstvwxyz]/i) } == n }.sort
end