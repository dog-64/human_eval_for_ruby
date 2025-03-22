def solve(s)
  if s.gsub(/[^a-zA-Z]/, '').empty?
    s.reverse
  else
    s.chars.map { |c| c.match?(/[a-zA-Z]/) ? c.swapcase : c }.join
  end
end