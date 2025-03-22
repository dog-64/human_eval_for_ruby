def check_last_char_letter?(txt)
  return false if txt.empty?
  txt = txt.strip
  return false if txt.empty?
  last_char = txt[-1]
  return false unless last_char =~ /[a-zA-Z]/
  return true if txt.length == 1
  second_last_char = txt[-2]
  return second_last_char == ' '
end