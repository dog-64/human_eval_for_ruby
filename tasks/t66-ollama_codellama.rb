def digit_sum(s)
  sum = 0
  s.each_char do |c|
    if c.upcase == c && c =~ /[A-Z]/
      sum += c.ord
    end
  end
  return sum
end