def solve(s)
  if s.match?(/[a-zA-Z]/)
    s.chars.map do |char|
      if char.match?(/[a-z]/)
        char.upcase
      elsif char.match?(/[A-Z]/)
        char.downcase
      else
        char
      end
    end.join
  else
    s.reverse
  end
end