def how_many_times(string, substring)
  count = 0
  (0..string.length - substring.length).each do |i|
    if string[i, substring.length] == substring
      count += 1
    end
  end
  count
end