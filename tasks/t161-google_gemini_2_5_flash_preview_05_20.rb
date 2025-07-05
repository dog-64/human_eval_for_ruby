def solve(s)
  if s.match?(/[A-Za-z]/)
    s.chars.map do |char|
      if char.match?(/[A-Z]/)
        char.downcase
      elsif char.match?(/[a-z]/)
        char.upcase
      else
        char
      end
    end.join
  else
    s.reverse
  end
end