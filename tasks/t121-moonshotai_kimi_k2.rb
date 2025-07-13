def sum_odd_even_pos(lst)
  lst.each_slice(2).sum { |pair| pair[0].odd? ? pair[0] : 0 }
end