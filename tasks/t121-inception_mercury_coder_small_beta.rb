def sum_odd_even_pos(lst)
  lst.each_with_index.select { |num, index| index.even? && num.odd? }.map(&:first).sum
end