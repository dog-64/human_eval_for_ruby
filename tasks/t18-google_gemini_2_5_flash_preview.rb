def how_many_times(string, substring)
  count = 0
  return 0 if string.empty? || substring.empty?

  (0..string.length - substring.length).each do |i|
    count += 1 if string[i, substring.length] == substring
  end
  count
end
