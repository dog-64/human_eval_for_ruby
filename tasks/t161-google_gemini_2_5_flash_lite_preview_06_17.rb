def solve(s)
  if s.scan(/[[:alpha:]]/).empty?
    s.reverse
  else
    s.each_char.map do |char|
      if char.match?(/[[:alpha:]]/)
        char.swapcase
      else
        char
      end
    end.join
  end
end