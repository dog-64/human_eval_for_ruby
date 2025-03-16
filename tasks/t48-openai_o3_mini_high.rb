def is_palindrome?(text)
  s = text.downcase.gsub(/[^[:alpha:]]/, '')
  s == s.reverse
end