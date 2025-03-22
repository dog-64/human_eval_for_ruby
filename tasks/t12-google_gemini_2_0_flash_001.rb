def longest(strings)
  return nil if strings.empty?

  longest_string = strings.first
  strings.each do |string|
    longest_string = string if string.length > longest_string.length
  end
  longest_string
end