def check_last_char_letter?(txt)
  return false if txt.empty?

  last_char = txt[-1]
  return false if last_char !~ /[a-zA-Z]/

  return true if txt[-2] !~ /[a-zA-Z]/ && txt[-2] != ' '

  return false
end
