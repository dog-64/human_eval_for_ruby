def choose_num(x, y)
  return -1 if x > y
  (x..y).select { |num| num.even? }.max || -1
end