def is_palindrome?(text)
  processed = text.downcase.gsub(/[^a-z]/, '')
  processed == processed.reverse
end