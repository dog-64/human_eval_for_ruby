def filter_by_substring(strings, substring)
  strings.select { |string| string.include?(substring) }
end