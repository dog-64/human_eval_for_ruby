def all_prefixes(string)
  (0...string.length).map { |i| string[0..i] }
end