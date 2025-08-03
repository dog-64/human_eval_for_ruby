
count_distinct_characters(string)
  seen = {}
  string.downcase.each_char { |char| seen[char] = true }
  seen.size
end