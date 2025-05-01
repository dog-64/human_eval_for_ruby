def check_last_char_letter?(txt)
  return false if txt.empty? || txt.strip.empty?

  last_char = txt[-1]
  return false unless last_char.match?(/[a-zA-Z]/)

  return true if txt.length == 1

  second_to_last_char = txt[-2]
  second_to_last_char == ' '
end