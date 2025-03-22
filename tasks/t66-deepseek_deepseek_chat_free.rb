def digit_sum(s)
  s.chars.sum { |c| c.match?(/[A-Z]/) ? c.ord : 0 }
end