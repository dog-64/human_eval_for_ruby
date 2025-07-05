def make_palindrome(string)
  if string.empty?
    ''
  else
    string + string.reverse()[1..-1]
  end
end
