def count_upper(s)
  s.split('').map.with_index { |c, i| c.upcase == 'A' && i.even? ? 1 : 0 }.sum
end