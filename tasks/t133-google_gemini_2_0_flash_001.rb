def sum_squares(lst)
  lst.map { |x| x.ceil }.map { |x| x * x }.sum
end