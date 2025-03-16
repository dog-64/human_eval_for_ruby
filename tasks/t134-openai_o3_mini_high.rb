def check_last_char_letter?(txt)
  !!(txt =~ /\A[[:alpha:]]\z|\A\S.*\s[[:alpha:]]\z/)
end