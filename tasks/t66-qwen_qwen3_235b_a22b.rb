def digit_sum(s)
  s.each_char.select { |c| c.match?(/[A-Z]/) }.map(&:ord).sum
end