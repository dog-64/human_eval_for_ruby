def filter_by_prefix(strings, prefix)
  strings.select { |s| s.start_with?(prefix) }
end