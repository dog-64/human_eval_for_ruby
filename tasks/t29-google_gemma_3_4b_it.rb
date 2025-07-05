def filter_by_prefix(strings, prefix)
  if prefix == ""
    strings
  else
    strings.select { |str| str.start_with?(prefix) }
  end
end
