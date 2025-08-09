def digit_sum(s)
  sum = 0
  s.each_char do |ch|
    if ch >= 'A' && ch <= 'Z'
      sum += ch.ord
    end
  end
  sum
end