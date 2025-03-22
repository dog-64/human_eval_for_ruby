def filter_by_prefix(strings, prefix)
  strings.select { |string| string.start_with?(prefix) }
end