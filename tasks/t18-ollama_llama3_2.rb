def how_many_times(string, substring)
  return 0 if string.empty?
  count = 0
  index = 0
  while (index = string.index(substring, index))
    count += 1
    index += substring.length
  end
  count
end