def check_last_char_letter?(txt)
  return false if txt.empty?
  last_char = txt[-1]
  last_char.match?(/[a-zA-Z]/) && last_char == txt.split.last
end