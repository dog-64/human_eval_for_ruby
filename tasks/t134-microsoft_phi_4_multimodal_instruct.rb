def check_last_char_letter?(txt)
  txt.strip.split.last.match?(/[a-zA-Z]/) && txt.strip.split.last != txt.strip.split[-2]
end