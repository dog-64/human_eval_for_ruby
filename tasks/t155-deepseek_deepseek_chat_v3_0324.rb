def even_odd_count(num)
  digits = num.abs.to_s.chars.map(&:to_i)
  even = digits.count { |d| d.even? }
  odd = digits.size - even
  [even, odd]
end