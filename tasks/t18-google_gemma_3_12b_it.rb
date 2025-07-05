def how_many_times(string, substring)
  return 0 if string.empty?
  return 0 if substring.empty?
  count = 0
  index = 0
  while index < string.length
    index = string.index(substring, index)
    break if index.nil?
    count += 1
    index += 1
  end
  count
end
