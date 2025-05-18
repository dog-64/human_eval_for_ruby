def sum_squares(lst)
  lst.sum { |num| num.ceil ** 2 }
end