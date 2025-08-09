def check_last_char_letter?(txt)
  return false if txt.nil? || txt.empty?
  return false if txt.strip.empty?
  last = txt[-1]
  return false unless last =~ /\p{L}/
  return true if txt.length == 1
  prev = txt[-2]
  return false unless prev == ' '
  prefix = txt[0...-2]
  !!(prefix =~ /[^\s]/)
end