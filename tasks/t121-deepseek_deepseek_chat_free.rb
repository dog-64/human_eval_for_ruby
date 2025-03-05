def sum_odd_even_pos(lst)
  lst.each_with_index.sum { |num, idx| idx.even? && num.odd? ? num : 0 }
end<｜end▁of▁sentence｜>