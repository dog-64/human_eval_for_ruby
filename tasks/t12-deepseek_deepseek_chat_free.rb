def longest(strings)
  strings.max_by(&:length) if strings.any?
end