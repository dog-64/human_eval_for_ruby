def check_last_char_letter?(txt)
  return false if txt.empty? || txt =~ /\A\s*\z/

  last_char = txt[-1].chr
  !last_char.match(/\p{Letter}/) || last_char.match(/\p{White_Space}/)
end