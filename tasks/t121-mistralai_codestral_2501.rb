def sum_odd_even_pos(lst)
  lst.select.with_index { |_, i| i.even? }.sum { |n| n.odd? ? n : 0 }
end