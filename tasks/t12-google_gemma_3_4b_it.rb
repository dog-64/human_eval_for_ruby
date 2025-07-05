def longest(strings)
  return nil if strings.empty?
  
  longest_string = strings[0]
  max_length = strings[0].length

  strings.each do |string|
    if string.length > max_length
      longest_string = string
      max_length = string.length
    end
  end

  longest_string
end
