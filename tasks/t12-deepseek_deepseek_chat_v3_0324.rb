def longest(strings)
  strings.max_by { |s| s.length } unless strings.empty?
end