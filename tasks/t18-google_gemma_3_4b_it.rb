def how_many_times(string, substring)
  return 0 if string.empty?
  
  count = 0
  string.length.times do |i|
    if string[i..i + substring.length - 1] == substring
      count += 1
    end
  end
  
  count
end
