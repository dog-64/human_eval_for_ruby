def solve(s)
  return s.reverse if s.empty? || s.chars.none? { |c| c.match?(/[A-Za-z]/) }
  s.chars.map { |c| c.match?(/[A-Za-z]/) ? c.swapcase : c }.join
end