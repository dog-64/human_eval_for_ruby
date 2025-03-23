
def how_many_times(string, substring)
  return 0 if string.empty?
  count = 0
  start = 0
  while (index = string.index(substring, start))
    count += 1
    start = index + 1
  end
  count
end
