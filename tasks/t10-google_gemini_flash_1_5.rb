def make_palindrome(string)
  return string if string.empty? || string == string.reverse
  string + string.reverse[1..-1]
end
