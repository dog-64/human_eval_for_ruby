def digit_sum(s)
  s.each_char.reduce(0) { |sum, char| sum + (char.ord if char.match?(/[A-Z]/)) }
end