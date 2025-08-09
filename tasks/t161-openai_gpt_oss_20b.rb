def solve(s)
  if s =~ /[[:alpha:]]/
    s.swapcase
  else
    s.reverse
  end
end