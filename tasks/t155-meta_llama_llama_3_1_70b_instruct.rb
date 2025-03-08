def even_odd_count(num)
  num = num.abs.to_s
  even_count = num.chars.count { |digit| digit.to_i.even? }
  odd_count = num.size - even_count
  [even_count, odd_count]
end