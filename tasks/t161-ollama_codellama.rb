def solve(s)
  s.chars.map { |c| c =~ /[a-zA-Z]/ ? c.swapcase : c }.join
end
