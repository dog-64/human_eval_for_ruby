
def solve(s)
  if s =~ /\p{Alpha}/
    s1 = s.swapcase
    match = s1.match(/^\p{Alpha}+/)
    if match && match.end(0) < s1.length
      reversed_group = match[0].reverse
      rest = s1[match.end(0)..-1]
      reversed_group + rest
    else
      s1
    end
  else
    s.reverse
  end
end