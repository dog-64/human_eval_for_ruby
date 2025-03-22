def is_palindrome?(text)
  cleaned_text = text.gsub(/[^a-zA-Z]/, '').downcase
  cleaned_text == cleaned_text.reverse
end