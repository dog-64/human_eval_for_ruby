
def filter_by_substring(strings, substring)
  strings.select { |s| s.include?(substring) }
end