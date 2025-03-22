def sum_squares(lst)
  lst.map { |num| (num + 0.5).ceil }.sum { |num| num ** 2 }
end