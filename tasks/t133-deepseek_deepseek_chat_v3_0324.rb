def sum_squares(lst)
  lst.sum(0) { |num| num.ceil.abs ** 2 }
end