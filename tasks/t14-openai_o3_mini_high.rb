def all_prefixes(string)
  (1..string.length).map { |i| string[0, i] }
end