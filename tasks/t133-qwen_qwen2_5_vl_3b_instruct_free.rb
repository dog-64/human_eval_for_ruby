def sum_squares(lst)
  lst.map { |num| num.ceil.to_i }.map { |num| num ** 2 }.sum
end
