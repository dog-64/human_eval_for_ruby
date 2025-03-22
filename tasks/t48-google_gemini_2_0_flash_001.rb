def is_palindrome?(text)
  processed_text = text.downcase.gsub(/[^a-z0-9]/, '')
  processed_text == processed_text.reverse
end