def check_last_char_letter?(txt)
  txt.strip[-1].match?(/[a-z]/) && !txt.strip.match?(/\s/)
end