
def sum_odd_even_pos(lst)
  lst.each_with_index.select { |num, i| i.even? && num.odd? }.map(&:first).sum
end

 