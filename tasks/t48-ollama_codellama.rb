def is_palindrome?(text)
  text = text.downcase.gsub(/[^a-z]/, '')
  text == text.reverse
end
