def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  count = 0
  pos = 0
  while pos = string.index(substring, pos)
    count += 1
    pos += 1
  end
  count
end