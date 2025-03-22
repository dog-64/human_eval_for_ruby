def solve(s)
  s = s.downcase
  s.chars.map { |c| c =~ /[a-z]/ ? c.swapcase : c }.join
end