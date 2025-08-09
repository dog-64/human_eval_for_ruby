def longest(strings)
  strings.max_by { |s| s.length }
end