def count_distinct_characters(string)
  distinct_chars = {}
  string.downcase.each_char do |char|
    distinct_chars[char] = true
  end
  distinct_chars.size
end
