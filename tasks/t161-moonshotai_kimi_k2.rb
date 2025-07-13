def solve(s)
  has_letters = s.match?(/[[:alpha:]]/)
  
  if has_letters
    s.chars.map do |char|
      if char.match?(/[[:upper:]]/)
        char.downcase
      elsif char.match?(/[[:lower:]]/)
        char.upcase
      else
        char
      end
    end.join
  else
    s.reverse
  end
end