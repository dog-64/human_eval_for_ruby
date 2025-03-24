def make_palindrome(string)
  return string if string.empty? || string == string.reverse
  i, j = 0, string.length - 1
  while i < j
    if string[i] != string[j]
      (i += 1) while i < j && string[i] != string[j]
      (j -= 1) while i < j && string[j] != string[i]
      return string[i..-1] + string[i...0].reverse
    end
    i += 1
    j -= 1
  end
  string
end
