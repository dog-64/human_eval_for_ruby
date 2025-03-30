
def is_palindrome?(text)
  cleaned = text.downcase.gsub(/[^a-z]/, '')
  cleaned == cleaned.reverse
end

 