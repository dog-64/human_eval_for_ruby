def filter_by_prefix(strings, prefix)
  strings.select { |str| str.start_with?(prefix) }
end