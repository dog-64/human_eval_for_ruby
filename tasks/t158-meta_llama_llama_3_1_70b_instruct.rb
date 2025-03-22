def find_max(words)
  words.map { |word| [word.chars.uniq.size, word] }.max[1] || ""
end