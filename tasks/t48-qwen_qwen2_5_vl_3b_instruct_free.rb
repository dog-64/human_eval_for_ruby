def is_palindrome?(text)
  cleaned_text = text.downcase.gsub(/[^a-z0-9]/, '')
  cleaned_text == cleaned_text.reverse
end