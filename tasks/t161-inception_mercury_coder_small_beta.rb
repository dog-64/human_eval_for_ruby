def solve(s)
  if s.match?(/[a-zA-Z]/)
    s.chars.map { |char| char.match?(/[a-z]/) ? char.upcase : char.downcase }.join
  else
    s.reverse
  end
end