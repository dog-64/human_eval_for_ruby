
def check_last_char_letter?(txt)
  return false if txt.empty?

  last_char = txt[-1]
  return false unless last_char.match?(/[a-zA-Z]/)

  return true if txt.length == 1

  prev_char = txt[-2]
  if prev_char == ' '
    (txt.length - 2) > 0
  else
    false
  end
end