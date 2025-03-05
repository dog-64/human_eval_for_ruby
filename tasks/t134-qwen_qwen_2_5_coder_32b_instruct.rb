def check_last_char_letter?(txt)
  return false if txt.strip.empty?

  parts = txt.split
  last_part = parts.last

  last_part.length == 1 && last_part =~ /[a-zA-Z]/
end