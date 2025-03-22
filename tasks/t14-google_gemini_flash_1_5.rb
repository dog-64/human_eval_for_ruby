def all_prefixes(string)
  string.chars.each_with_object([]) { |char, arr| arr << (arr.last || '') + char }
end
