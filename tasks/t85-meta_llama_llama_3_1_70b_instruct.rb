def add_even_at_odd(lst)
  lst.each_with_index.sum { |x, i| i.odd? && x.even?? x : 0 }
end