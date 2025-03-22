def make_palindrome(string)
  return string if string.empty?
  
  n = string.length
  i = 0
  while string[0, n - i] != string[0, n - i].reverse
    i += 1
  end
  
  string + string[0, i].reverse
end