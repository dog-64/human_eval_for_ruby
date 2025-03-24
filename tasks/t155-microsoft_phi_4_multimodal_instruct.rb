def even_odd_count(num)
  num = num.abs
  digits = num.to_s.chars.map(&:to_i)
  even_count = digits.count(&:even?)
  odd_count = digits.count(&:odd?)
  [even_count, odd_count]
end