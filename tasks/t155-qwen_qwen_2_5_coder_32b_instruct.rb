def even_odd_count(num)
  num = num.abs.to_s.chars
  even_count = num.count { |digit| digit.to_i.even? }
  odd_count = num.count { |digit| digit.to_i.odd? }
  [even_count, odd_count]
end