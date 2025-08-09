def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  count = 0
  i = 0
  while i <= string.length - substring.length
    count += 1 if string[i, substring.length] == substring
    i += 1
  end
  count
end