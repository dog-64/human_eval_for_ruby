def solve(s)
  if s.all? { |char| !char.match(/[a-zA-Z]/) }
    s.reverse
  else
    s.chars.map { |char| 
      char.upcase == char ? char.downcase : char
    }.join
  end
end
