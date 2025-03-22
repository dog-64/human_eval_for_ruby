def check_last_char_letter?(txt)
  return false if txt.empty?
  last_char = txt[-1]
  return false unless last_char.match?(/[a-zA-Z]/)
  return true if txt.length == 1
  txt[-2] == ' '
end