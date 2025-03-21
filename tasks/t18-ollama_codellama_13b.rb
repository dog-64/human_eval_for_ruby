def how_many_times(string, substring)
  count = 0
  i = 0
  while i < string.length
    j = 0
    while j < substring.length && i + j < string.length
      if string[i + j] == substring[j]
        j += 1
      else
        break
      end
    end
    if j == substring.length
      count += 1
      i += substring.length
    else
      i += 1
    end
  end
  count
end