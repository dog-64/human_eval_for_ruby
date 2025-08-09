def filter_by_prefix(strings, prefix)
  return strings if prefix.empty?
  strings.select { |s| s.start_with?(prefix) }
end