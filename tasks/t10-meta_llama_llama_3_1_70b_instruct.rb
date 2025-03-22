def make_palindrome(string)
  string + string[0..-2].reverse unless string == string.reverse
end