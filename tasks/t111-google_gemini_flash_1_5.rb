def histogram(text)
  counts = {}
  text.downcase.scan(/[a-z]/) { |char| counts[char] = counts.fetch(char, 0) + 1 }
  counts
end
