def find_max(words)
  return "" if words.empty?

  words.max_by { |word| [word.chars.uniq.size, -word] }
end