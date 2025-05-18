def solve(s)
  s.match?(/\p{L}/) ? s.swapcase : s.reverse
end