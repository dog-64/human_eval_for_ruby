def how_many_times(string, substring)
  count = 0
  len = substring.length
  (0..string.length - len).each do |i|
    count += 1 if string[i, len] == substring
  end
  count
end
