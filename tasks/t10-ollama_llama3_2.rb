def make_palindrome(string)
  string.empty? ? '' : string + string.reverse[1..-1]
end