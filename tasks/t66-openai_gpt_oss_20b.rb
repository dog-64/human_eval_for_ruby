def digit_sum(s)
  sum = 0
  s.each_char do |c|
    if c >= 'A' && c <= 'Z'
      sum += c.ord
    end
  end
  sum
end