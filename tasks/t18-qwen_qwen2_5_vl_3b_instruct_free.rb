def how_many_times(string, substring)
  return 0 if string.empty?
  return 0 if substring.empty?

  count = 0
  (string.length - substring.length + 1).times do |i|
    if string[i..i + substring.length - 1] == substring
      count += 1
    end
  end
  count
end