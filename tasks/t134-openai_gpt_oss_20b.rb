def check_last_char_letter?(txt)
  return false if txt.nil? || txt.empty?
  return false if txt.strip.empty?

  last_char = txt[-1]
  return false unless last_char =~ /[A-Za-z]/

  if txt.length > 1
    prev_char = txt[-2]
    return false if prev_char =~ /[A-Za-z]/
  end

  return false if txt[0] == ' '

  true
end