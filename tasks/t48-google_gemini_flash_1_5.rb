def is_palindrome?(text)
  processed_text = text.downcase.gsub(/[^a-z]/i, '')
  processed_text == processed_text.reverse
end
