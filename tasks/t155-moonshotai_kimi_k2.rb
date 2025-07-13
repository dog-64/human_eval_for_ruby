def even_odd_count(num)
  num = num.abs
  digits = num.to_s.chars.map(&:to_i)
  even_count = digits.count { |digit| digit.even? }
  odd_count = digits.count { |digit| digit.odd? }
  [even_count, odd_count]
end