def find_max(words)
  words.max_by { |word| word.chars.uniq.size }
end