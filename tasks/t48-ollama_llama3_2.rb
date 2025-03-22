def is_palindrome?(text)
  text = text.downcase.gsub(/[^a-z0-9]/, '')
  text == text.reverse
end