def solve(s)
  s.chars.map { |c| c =~ /[a-zA-Z]/ ? c.upcase : c }.join
end