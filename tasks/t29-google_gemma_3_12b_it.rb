def filter_by_prefix(strings, prefix)
  return [] if strings.empty?
  return strings if prefix.empty?
  strings.select { |str| str.start_with?(prefix) }
end
