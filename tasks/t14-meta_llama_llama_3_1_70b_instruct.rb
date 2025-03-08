def all_prefixes(string)
  string.chars.each_with_index.map { |char, index| string[0..index] }.sort_by(&:length)
end