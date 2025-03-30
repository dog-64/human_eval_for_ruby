
def even_odd_count(num)
  num = num.abs
  return [1, 0] if num == 0
  digits = num.to_s.delete('-').chars.map(&:to_i)
  even_count = digits.count(&:even?)
  [even_count, digits.size - even_count]
end

 