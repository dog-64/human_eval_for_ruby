def solve(s)
  return s.reverse if s.match?(/\A[\W_]+\z/)
  s.chars.map { |c| c =~ /[a-zA-Z]/ ? c.swapcase : c }.join
end