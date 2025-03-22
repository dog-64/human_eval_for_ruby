def longest(strings)
  return nil if strings.empty?
  strings.max { |a, b| a.size <=> b.size }
end