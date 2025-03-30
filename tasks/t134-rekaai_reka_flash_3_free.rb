
def check_last_char_letter?(txt)
  return false if txt.strip.empty?

  if txt.length == 1
    txt =~ /[[:alpha:]]/
  else
    !!txt.match(/^(.*[^\s])[[:space:]][[:alpha:]]$/)
  end
end

 