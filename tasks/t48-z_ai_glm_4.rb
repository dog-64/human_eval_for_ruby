def is_palindrome?(text)
  cleaned = text.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end