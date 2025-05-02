def find_max(words)
  return "" if words.empty?

  words.sort_by { |word| [ -word.chars.uniq.size, word ] }.first
end