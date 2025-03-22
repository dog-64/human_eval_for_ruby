def check_last_char_letter?(txt)
  return false if txt.empty? || txt.strip.empty?

  last_char = txt[-1]
  return false unless last_char =~ /[a-zA-Z]/

  prev_char = txt[-2]
  return false if prev_char && prev_char =~ /[a-zA-Z]/

  true
end