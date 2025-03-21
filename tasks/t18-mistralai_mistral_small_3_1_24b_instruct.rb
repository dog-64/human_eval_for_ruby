def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?
  count = 0
  start = 0
  while (index = string.index(substring, start)) != nil
    count += 1
    start = index + 1
  end
  count
end