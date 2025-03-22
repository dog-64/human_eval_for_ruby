def is_palindrome?(text)
  text = text.downcase.gsub(/[^a-z]/, "")
  text == text.reverse
end
is_palindrome?("")  # => true
is_palindrome?("aba") # => true
is_palindrome?("A man, a plan, a canal: Panama") # => true
is_palindrome?("aaaaa") # => true
is_palindrome?("zbcd") # => false
is_palindrome?("race a car") # => false