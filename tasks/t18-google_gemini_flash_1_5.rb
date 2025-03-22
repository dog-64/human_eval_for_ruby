def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  count = 0
  (string.length - substring.length + 1).times do |i|
    count += 1 if string[i, substring.length] == substring
  end
  count
end
