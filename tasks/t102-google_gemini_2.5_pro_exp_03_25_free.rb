def choose_num(x, y)
  (x..y).reverse_each.find { |num| num.even? } || -1
end
