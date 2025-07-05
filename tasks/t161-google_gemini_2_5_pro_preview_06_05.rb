
def")` => `"cba123DEF"` seems to imply that the *entire string* is reversed *after* swapping the case of the letters. Let'
def solve(s)
  if s.match?(/\p{L}/)
    s.swapcase.reverse
  else
    s.reverse
  end