def check_last_char_letter?(txt)
  return false if txt.empty? || txt.end_with?(' ')
  last_char = txt[-1]
  second_last_char = txt[-2]
  last_char.match?(/\A[a-zA-Z]\z/) && !second_last_char.match?(/\A[a-zA-Z]\z/)
end