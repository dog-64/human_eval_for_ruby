
def filter_by_substring(strings, substring)
  strings.filter { |string| string.include?(substring) }
end
