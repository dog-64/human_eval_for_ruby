def is_palindrome?(text)
  sanitized_text = text.downcase.gsub(/[^a-z]/, '')
  sanitized_text == sanitized_text.reverse
end