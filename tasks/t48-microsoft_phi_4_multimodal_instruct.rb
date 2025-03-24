def is_palindrome?(text)
  cleaned_text = text.downcase.gsub(/[^a-z0-9]/i, '')
  cleaned_text == cleaned_text.reverse
end