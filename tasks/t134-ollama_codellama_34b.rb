[PYTHON]
def check_last_char_letter?(txt)
  # Check if the last character is a letter and not part of a word
  return false if txt.empty?
  last_char = txt[-1]
  return false if last_char == " "
  return true if last_char =~ /[a-zA-Z]/ && txt[-2].nil?
  return false if txt[-2] == " "
  true
end
[/PYTHON]
