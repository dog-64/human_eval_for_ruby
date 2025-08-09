def is_palindrome?(text)
  filtered = text.downcase.gsub(/[^a-z]/, '')
  filtered == filtered.reverse
end