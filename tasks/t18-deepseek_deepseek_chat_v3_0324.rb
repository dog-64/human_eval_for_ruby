def how_many_times(string, substring)
  return 0 if substring.empty? || string.empty?
  count = 0
  (0..string.length - substring.length).each do |i|
    count += 1 if string[i, substring.length] == substring
  end
  count
end