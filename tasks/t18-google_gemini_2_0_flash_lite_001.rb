def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?

  count = 0
  i = 0
  while i <= string.length - substring.length
    if string[i, substring.length] == substring
      count += 1
    end
    i += 1
  end
  count
end