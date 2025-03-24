def how_many_times(string, substring)
  count = 0
  position = string.index(substring)
  while position != nil
    count += 1
    position = string.index(substring, position + 1)
  end
  count
end