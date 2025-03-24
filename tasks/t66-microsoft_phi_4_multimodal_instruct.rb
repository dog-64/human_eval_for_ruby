def digit_sum(s)
  s.upcase.chars.select { |c| c.between?('A', 'Z') }.sum { |c| c.ord }
end