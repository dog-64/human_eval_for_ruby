def sum_squares(lst)
  lst.sum { |x| x.ceil ** 2 }
end
