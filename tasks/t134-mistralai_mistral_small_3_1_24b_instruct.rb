def check_last_char_letter?(txt)
  return false if txt.empty? || txt.strip.empty?
  last_char = txt[-1]
  return false unless last_char =~ /[a-zA-Z]/
  txt[-2] == ' ' && txt[-2] != nil
end