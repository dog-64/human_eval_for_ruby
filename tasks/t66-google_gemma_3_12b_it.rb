def digit_sum(s)
  sum = 0
  s.each_char do |char|
    if char.match?(/[A-Z]/)
      sum += char.ord
    end
  end
  sum
end
