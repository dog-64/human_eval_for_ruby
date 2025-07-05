def check_last_char_letter?(txt)
  return false if txt.empty?
  last_char = txt[-1]
  return false unless last_char.match?(/[[:alpha:]]/)
  return true if txt.length == 1
  prev_char = txt[-2]
  prev_char == ' '
end