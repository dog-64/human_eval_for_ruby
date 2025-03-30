
def digit_sum(s)
  s.chars.select { |c| c >= 'A' && c <= 'Z' }.sum { |c| c.ord }
end

 