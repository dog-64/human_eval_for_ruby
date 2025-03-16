def how_many_times(string, substring)
  return 0 if string.empty? || substring.empty?

  count = 0
  index = 0

  while (index = string.index(substring, index))
    count += 1
    index += 1
  end

  count
end