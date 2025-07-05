def all_prefixes(string)
  string.chars.each_with_object([]) do |char, prefixes|
    prefixes << string[0...prefixes.length + 1] if prefixes.length < string.length
  end
end
