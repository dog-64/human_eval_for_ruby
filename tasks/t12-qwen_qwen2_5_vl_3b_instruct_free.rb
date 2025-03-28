def longest(strings)
  return nil if strings.empty?

  strings.max_by(&:length)
end