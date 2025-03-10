def check_last_char_letter?(txt)
  return false if txt.empty?
  txt = txt.strip
  return false if txt.empty?
  last_char = txt[-1]
  return false unless last_char =~ /[a-zA-Z]/
  return true if txt.size == 1
  return false if txt[-2] =~ /[a-zA-Z]/
  true
end