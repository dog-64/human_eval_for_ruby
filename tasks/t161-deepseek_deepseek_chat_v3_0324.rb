def solve(s)
  has_letters = s.chars.any? { |c| c.match?(/[[:alpha:]]/) }
  if has_letters
    s.chars.map do |c|
      if c.match?(/[[:alpha:]]/)
        c == c.upcase ? c.downcase : c.upcase
      else
        c
      end
    end.join
  else
    s.reverse
  end
end