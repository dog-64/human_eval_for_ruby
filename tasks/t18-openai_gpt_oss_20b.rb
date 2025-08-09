def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  count = 0
  i = 0
  while i <= string.length - substring.length
    if string[i, substring.length] == substring
      count += 1
      i += 1
    else
      i += 1
    end
  end
  count
end