def solve(s)
  if s.match(/[a-zA-Z]/)
    s.chars.map { |c| c =~ /[a-zA-Z]/ ? c.swapcase : c }.join
  else
    s.reverse
  end
end