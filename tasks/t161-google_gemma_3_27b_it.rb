def solve(s)
  if s.chars.none? { |c| c =~ /[a-zA-Z]/ }
    s.reverse
  else
    s.chars.map { |c|
      if c =~ /[a-zA-Z]/
        c == c.upcase ? c.downcase : c.upcase
      else
        c
      end
    }.join
  end
end