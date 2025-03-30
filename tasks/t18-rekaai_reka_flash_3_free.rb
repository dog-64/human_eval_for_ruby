
def how_many_times(string, substring)
  return 0 if substring.empty?
  return 0 if string.length < substring.length

  count = 0
  max_index = string.length - substring.length
  (0..max_index).each do |i|
    count += 1 if string[i, substring.length] == substring
  end

  count
end

 