def even_odd_count(num)
  digits = num.abs.to_s.chars
  even_count = digits.count { |d| d.to_i.even? }
  odd_count = digits.count { |d| d.to_i.odd? }
  [even_count, odd_count]
end