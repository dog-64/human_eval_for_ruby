
def check_last_char_letter?(txt)
  return false if txt.empty?

  last_char = txt[-1]
  return false unless last_char =~ /[a-zA-Z]/

  if txt.length > 1
    penultimate_char = txt[-2]
    return false if penultimate_char =~ /[a-zA-Z]/
  end

  if txt.end_with?(" ")
    return false
  end

  true
end
