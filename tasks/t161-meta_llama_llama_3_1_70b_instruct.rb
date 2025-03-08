def solve(s)
  s.each_char.map do |c|
    if c.match?(/[[:alpha:]]/)
      c.swapcase
    else
      c
    end
  end.join.tap do |result|
    result.reverse! if s.each_char.none? { |c| c.match?(/[[:alpha:]]/) }
  end
end