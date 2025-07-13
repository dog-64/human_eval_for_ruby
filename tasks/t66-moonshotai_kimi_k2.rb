def digit_sum(s)
  s.chars.select { |char| char.match?(/[A-Z]/) }.sum(&:ord)
end