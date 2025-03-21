def solve(s)
  if s.match?(/[[:alpha:]]/)
    s.chars.map { |c| c =~ /[[:alpha:]]/ ? c.swapcase : c }.join
  else
    s.reverse
  end
end