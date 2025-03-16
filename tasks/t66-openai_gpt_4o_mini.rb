def digit_sum(s)
  s.each_char.select { |c| c >= 'A' && c <= 'Z' }.sum { |c| c.ord }
end