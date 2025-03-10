def filter_by_substring(strings, substring)
  strings.select { |str| str.include?(substring) }
end