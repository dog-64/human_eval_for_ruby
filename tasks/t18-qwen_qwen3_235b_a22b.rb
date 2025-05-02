def how_many_times(string, substring)
  sub_len = substring.length
  return 0 if sub_len == 0 || string.length < sub_len

  count = 0
  max_index = string.length - sub_len
  (0..max_index).each do |i|
    count += 1 if string[i, sub_len] == substring
  end
  count
end