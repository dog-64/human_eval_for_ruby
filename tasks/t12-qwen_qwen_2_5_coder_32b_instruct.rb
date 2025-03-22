def longest(strings)
  strings.max_by { |str| str.length }
end