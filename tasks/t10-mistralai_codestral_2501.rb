def make_palindrome(string)
  (string + string.reverse).slice(0, string.size * 2 - 1)
end