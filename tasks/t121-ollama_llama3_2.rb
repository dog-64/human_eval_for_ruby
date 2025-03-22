def sum_odd_even_pos(lst)
  lst.each_with_index { |x, i| break x if i.even? && x.odd? }
end