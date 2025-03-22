def sum_odd_even_pos(lst)
  lst.each_with_index.sum { |num, idx| num.odd? && idx.even? ? num : 0 }
end