def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  
  count = 0
  index = 0
  
  while index <= string.length - substring.length
    if string[index, substring.length] == substring
      count += 1
      index += 1
    else
      index += 1
    end
  end
  
  count
end