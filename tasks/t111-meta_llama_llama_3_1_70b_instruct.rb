def histogram(text)
  text.downcase.scan(/[a-z]/).tally
end