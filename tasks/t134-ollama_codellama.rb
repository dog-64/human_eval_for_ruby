def check_last_char_letter?(txt)
  return false if txt.empty? || txt =~ /\s$/
  !(txt[-1].match?(/[a-zA-Z]/) && txt[-2..-3].match?(/[a-zA-Z]/))
end
