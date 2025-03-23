
def longest(strings)
  return nil if strings.empty?
  longest_string = strings[0]
  strings.each do |string|
    if string.length > longest_string.length
      longest_string = string
    end
  end
  longest_string
end
