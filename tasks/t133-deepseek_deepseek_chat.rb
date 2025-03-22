def sum_squares(lst)
  lst.map { |x| x.ceil }.sum { |x| x**2 }
end